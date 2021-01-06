Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3552EBFDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAFOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbhAFOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:52:49 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC950C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:52:07 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x13so3670559oic.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 06:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xx6kwSq6FUJ/JoFUqNa64FTW5kY/WorplF8mbM+IY0w=;
        b=S0ZG5hwpGpF0JOxtIXvDhLHwgbcXdAu6PQsvhT6XrR28iMznJ++FXmAFJOAR6cI3Ni
         Q2MY69P9wvpZ4FGi1tkgH0pCoBDMSUqUYup/9DmtkntXUzxeff/PodKjkYGKNz59Tsmx
         /7fmRGQs84IhYQWjdites5hOfG1x6uugZJPyZPnJQFc8Wx9e8I0jUxXa0otewQiIgVpf
         eD9l+FO3I9CqhuE2tr8+xqtYDN1vhYafs01dS2n88wP2atRO0YGJ9MlgtZhl3z+kueo9
         l+wqIJTWQ1hgFUwRAYGnwSOZj+E71irKJl7Lurqptvj92BnW4kTgsRXm8DSE0Hf3ptVE
         btrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xx6kwSq6FUJ/JoFUqNa64FTW5kY/WorplF8mbM+IY0w=;
        b=ZR4SpbkmPFyGXHy/JsO4FLQa77DP7W1rqer1wE1nPhUAEm19YjMzTfSktCI8ho44b2
         Ummh1OZIS2T37ucEapkwqcofZ4HfMaymNgZQRLHdd4jjsJSE70elMoVhqSooriSUBFC+
         40mQGcoHRStntU+UTSO31exvWN0SaV77duHk9xZ4O8/crZhNmV5SoGzotEYA/eWERWrb
         U8uaDZDD6hGfYLvG6Gbpj5QS0CNXwDSK4s765OWopd7CFpFPlTv8eyUCoTa5LK3OtPgA
         bC8EEtS1hEGYNb96z6PM0b1s2+T2NiNWGeV+Y+AUZy9AL248/4PgDIpgoCBUFoeBMXjg
         7c6w==
X-Gm-Message-State: AOAM533H0cUz2paw7e4RIopGRYaJBic+BBU9rKP4nQP62QtXDafJyX2M
        +x+21voVCcEEOYT67EqQZlyfxq/Wfae3okF0BCC99mCuFZ0Kyg==
X-Google-Smtp-Source: ABdhPJx1Rcfp6esyHd9OhY8F8jRa/cvCCbhOkdex0BsgkCLyWOWLcnCX/dbI20lMa4apLaZ3RLmYQsIUiWTBhEjn5Z0=
X-Received: by 2002:aca:3194:: with SMTP id x142mr3427193oix.82.1609944726762;
 Wed, 06 Jan 2021 06:52:06 -0800 (PST)
MIME-Version: 1.0
References: <CAFSh4UwMr7t+R9mWUCjdecadJL6=_7jdgagAQK6Y1Yj0+Eu0sg@mail.gmail.com>
 <CAFSh4UwAmR+sdfbdyxHRDnDr8r+TXxo2bvWtY3gmLAJekWc3Sw@mail.gmail.com>
In-Reply-To: <CAFSh4UwAmR+sdfbdyxHRDnDr8r+TXxo2bvWtY3gmLAJekWc3Sw@mail.gmail.com>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Wed, 6 Jan 2021 14:51:55 +0000
Message-ID: <CAFSh4Uwsj5GfPRUe+oT8h=DBxHppqbE-zsDV8-J5rTK3-xyZFQ@mail.gmail.com>
Subject: Re: cBPF socket filters failing - inexplicably?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another factoid to add to this:  I captured all traffic on an
interface while the test program was running using

tcpdump -i wlo1 -w capture.pcap

observing that multiple packets got through the filter.  I then built
the bpf_dbg program from the kernel source tree and ran the same
filter and capture file through it:

$ tools/bpf_dbg
> load bpf 1,6 0 0 0
> load pcap capture.pcap
> run
bpf passes:0 fails:269288

So bpf_dbg thinks the filter is correct; it's only when the filter is
attached to an actual socket that it fails occasionally.

Regards,
Tom

On Wed, Jan 6, 2021 at 10:07 AM Tom Cook <tom.k.cook@gmail.com> wrote:
>
> Just to note I have also reproduced this on a 5.10.0 kernel.
>
> On Tue, Jan 5, 2021 at 1:42 PM Tom Cook <tom.k.cook@gmail.com> wrote:
> >
> > In the course of tracking down a defect in some existing software,
> > I've found the failure demonstrated by the short program below.
> > Essentially, a cBPF program that just rejects every frame (ie always
> > returns zero) and is attached to a socket using setsockopt(SOL_SOCKET,
> > SO_ATTACH_FILTER, ...) still occasionally lets frames through to
> > userspace.
> >
> > The code is based on the first example in
> > Documentation/networking/filter.txt, except that I've changed the
> > content of the filter program and added a timeout on the socket.
> >
> > To reproduce the problem:
> >
> > # gcc test.c -o test
> > # sudo ./test
> > ... and in another console start a large network operation.
> >
> > In my case, I copied a ~300MB core file I had lying around to another
> > host on the LAN.  The test code should print the string "Failed to
> > read from socket" 100 times.  In practice, it produces about 10%
> > "Received packet with ethertype..." messages.
> >
> > I've observed the same result on Ubuntu amd64 glibc system running a
> > 5.9.0 kernel and also on Alpine arm64v8 muslc system running a 4.9.1
> > kernel.  I've written test code in both C and Python.  I'm fairly sure
> > this is not something I'm doing wrong - but very keen to have things
> > thrown at me if it is.
> >
> > Regards,
> > Tom Cook
> >
> >
> > #include <stdio.h>
> > #include <sys/socket.h>
> > #include <sys/types.h>
> > #include <arpa/inet.h>
> > #include <linux/if_ether.h>
> > #include <linux/filter.h>
> > #include <stdint.h>
> > #include <unistd.h>
> >
> > struct sock_filter code[] = {
> >     { 0x06,    0,    0,    0x00 }  /* BPF_RET | BPF_K   0   0   0 */
> > };
> >
> > struct sock_fprog bpf = {
> >     .len = 1,
> >     .filter = code,
> > };
> >
> > void test() {
> >     uint8_t buf[2048];
> >
> >     int sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> >     if (sock < 0) {
> >         printf("Failed to open socket\n");
> >         return;
> >     }
> >     int ret = setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &bpf, sizeof(bpf));
> >     if (ret < 0) {
> >         printf("Failed to set socket filter\n");
> >         return;
> >     }
> >     struct timeval tv = {
> >         .tv_sec = 1
> >     };
> >
> >     ret = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
> >     if (ret < 0) {
> >         printf("Failed to set socket timeout\n");
> >         return;
> >     }
> >
> >     ssize_t count = recv(sock, buf, 2048, 0);
> >     if (count <= 0) {
> >         printf("Failed to read from socket\n");
> >         return;
> >     }
> >
> >     close(sock);
> >
> >     uint16_t *ethertype = (short*)(buf + 12);
> >     uint8_t *proto = (unsigned char *)(buf + 23);
> >     uint16_t *dport = (uint16_t *)(buf + 14 + 20);
> >
> >     printf("Received packet with ethertype 0x%04hu, protocol 0x%02hhu
> > and dport 0x%04hu\n", *ethertype, *proto, *dport);
> > }
> >
> > int main() {
> >     for (size_t ii = 0; ii < 100; ++ii) {
> >         test();
> >     }
> > }
