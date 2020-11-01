Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10562A1DA3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 12:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKALlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 06:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgKALlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:41:37 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BF4C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 03:41:37 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 141so13709373lfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vE+kC+A2VtoW9DT/RZQzhv7ZNYaInonkNcxpMpbSM+g=;
        b=csv/7BOjVnNPb13k2e9k7oAz/KX07fOskCrtW+1AFv2EE6rzrbVa1J44nAzt/MDSAd
         GwKewslY+k0vYVsVCD3Tl1TnLTJxqfdl/xDvO/+zavX2IP4yPz1MyRkjn28eFzuV0MmA
         Sol0v0ZjKU5b7rBDlgosZH2GGyX1Bm6yf5mDGCnNUvpdqnRLY7sCrdwfFJ9iQc44EmSq
         g4r9BaEMTKNSD4MpCLmMWJPSdybG2yQJcr3mNfHy1TWYqcJEKY5308kpd4HrAyQGNjk3
         HNs8pvkym6Z62dn7+VsZ8VDnYEdEkGVbSZj5rumVEYOnTnON3imfllHddl/7pDo4f8DH
         x4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vE+kC+A2VtoW9DT/RZQzhv7ZNYaInonkNcxpMpbSM+g=;
        b=Gj4F07P9saQIO3bzhWccFR5LSnoUiRois0qpaTTkiD/FByZ62QQPaWUpEwN+uxn94D
         W4CF+9uepWxkeZdAfk7ig0nK49gkNOvLdSANg3D6oYZ9jrsD70H+pOljN5i8C2v7hOAn
         +d6hGF5gNfL5DdNMICI3W+ObWqtGS9FsmQyKOmNJdLmK1FwdFTOsehpbaL7nZBm8AFcU
         cRpdcUJHIjpFWoOZEWMjYRVcFTmJ7x4Jcrtgq/tt1Y3uusvqmd7MsfDL3DWb6SnjApdr
         qm1JSHpkK1L7thsvhcaXvOHZMo0rNN+xKs/jEQqkAeFo7NkkrJVtDwSq8ImPVY6UeIo6
         C6gA==
X-Gm-Message-State: AOAM533KYPMBn5Lvua7pvJlIUH6DoN/AJENmbaI7DyLxncLf/C84ZBD8
        9PDr64QJhS6GMC2Mxe4xBd6p2JvjxnF2uw==
X-Google-Smtp-Source: ABdhPJzTyJaOgR6sLbJ8Q3gm5CTxoJ7vmnJTMZiTqr6ItplKz8DMRI/avr3NT7zSc+HQNhvLQXOH0w==
X-Received: by 2002:a19:f119:: with SMTP id p25mr3799303lfh.151.1604230893778;
        Sun, 01 Nov 2020 03:41:33 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id x69sm1453725lff.54.2020.11.01.03.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 03:41:33 -0800 (PST)
Subject: Re: [PATCH] mm: optionally disable brk()
To:     David Hildenbrand <david@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
 <4d325e3e-3139-eded-6781-435fb04fb915@gmail.com>
 <9dc586f4-38f0-7956-0ab6-bd7921491606@redhat.com>
 <5fb32353b1964299809fce0c7579a092@AcuMS.aculab.com>
 <b6baf73e-35fd-fe12-bb5f-b9b4e334ae83@redhat.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <ced9ebac-7222-1cd5-e1e4-d05b2f175984@gmail.com>
Date:   Sun, 1 Nov 2020 13:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b6baf73e-35fd-fe12-bb5f-b9b4e334ae83@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2020 15.18, David Hildenbrand wrote:
> On 05.10.20 13:21, David Laight wrote:
>> From: David Hildenbrand
>>> Sent: 05 October 2020 10:55
>> ...
>>>> If hardening and compatibility are seen as tradeoffs, perhaps there
>>>> could be a top level config choice (CONFIG_HARDENING_TRADEOFF) for this.
>>>> It would have options
>>>> - "compatibility" (default) to gear questions for maximum compatibility,
>>>> deselecting any hardening options which reduce compatibility
>>>> - "hardening" to gear questions for maximum hardening, deselecting any
>>>> compatibility options which reduce hardening
>>>> - "none/manual": ask all questions like before
>>>
>>> I think the general direction is to avoid an exploding set of config
>>> options. So if there isn't a *real* demand, I guess gluing this to a
>>> single option ("CONFIG_SECURITY_HARDENING") might be good enough.
>>
>> Wouldn't that be better achieved by run-time clobbering
>> of the syscall vectors?
> 
> You mean via something like a boot parameter? Possibly yes.
> 

This may be obvious, but a global seccomp filter which doesn't affect 
NNP can be installed in initrd with a simple program with no changes to 
kernel:

#include <errno.h>
#include <seccomp.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv) {
         if (argc < 3) {
                 fprintf(stderr, "Usage: %s syscall [syscall]... 
program\n", argv[0]);
                 return EXIT_FAILURE;
         }

         scmp_filter_ctx ctx = seccomp_init(SCMP_ACT_ALLOW);

         if (ctx == NULL) {
                 fprintf(stderr, "failed to init filter\n");
                 return EXIT_FAILURE;
         }

         int r;
         r = seccomp_attr_set(ctx, SCMP_FLTATR_CTL_NNP, 0);
         if (r != 0) {
                 fprintf(stderr, "failed to disable NNP\n");
                 return EXIT_FAILURE;
         }

         fprintf(stderr, "filtering");
         for (int i = 1; i < argc - 1; i++) {
                 const char *syscall = argv[i];

                 int syscall_nr = seccomp_syscall_resolve_name(syscall);

                 if (syscall_nr == __NR_SCMP_ERROR) {
                         //fprintf(stderr, "unknown syscall %s, 
ignoring\n", syscall);
                         continue;
                 }
                 r = seccomp_rule_add_exact(ctx, SCMP_ACT_ERRNO(ENOSYS), 
syscall_nr, 0);
                 if (r != 0) {
                         //fprintf(stderr, "failed to filter syscall %s, 
ignoring\n", syscall);
                         continue;
                 }
                 fprintf(stderr, " %s", syscall);
         }
         fprintf(stderr, "\n");
         r = seccomp_load(ctx);
         if (r != 0) {
                 fprintf(stderr, "failed to apply filter\n");
                 return EXIT_FAILURE;
         }

         seccomp_release(ctx);

         char *program = argv[argc - 1];
         char *new_argv[] = { program, NULL };

         execv(program, new_argv);

         fprintf(stderr, "failed to exec %s\n", program);
         return EXIT_FAILURE;
}

This can be inserted in initrd to disable some obsolete and old system 
calls like this:
#!/bin/sh

exec /usr/local/sbin/seccomp-exec _sysctl afs_syscall bdflush break 
create_module ftime get_kernel_syms getpmsg gtty idle lock mpx prof 
profil putpmsg query_module security sgetmask ssetmask stty sysfs 
tuxcall ulimit uselib ustat vserver epoll_ctl_old epoll_wait_old 
old_adjtimex old_getpagesize oldfstat oldlstat oldolduname oldstat 
oldumount olduname osf_old_creat osf_old_fstat osf_old_getpgrp 
osf_old_killpg osf_old_lstat osf_old_open osf_old_sigaction 
osf_old_sigblock osf_old_sigreturn osf_old_sigsetmask osf_old_sigvec 
osf_old_stat osf_old_vadvise osf_old_vtrace osf_old_wait osf_oldquota 
vm86old brk /init

-Topi
