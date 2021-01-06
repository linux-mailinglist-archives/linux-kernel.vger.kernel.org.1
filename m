Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3072EBC1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbhAFKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAFKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:08:00 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FB1C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:07:20 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id l207so2913876oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E/SBnC7k7s+gyUl8RdyAj6nVYL4y6pk4li2IeqeZSKs=;
        b=YojB1mCxSFBqxtVnmh3s8h8YdCoZiz/kUHO8goGPyh3XOHtRmEYIF+3wO9e9q3znHk
         VWa97yT69DdqsrWkKahDhwdue4VS2FiQ9SmxcR0a5E9bNZhKQ7z2F9+ySYil4HgBe24c
         DIDbLkA44My+1Zb8/fB1h1xH3hcrdW9MVV1wKlgDAqwEOJOd114fFXp4nuZcHMjAB4dW
         FjbW1RRHld7uktQkRipI75FBBqIfAGtlVZkYrcFPRIZ77ib5XbZ2SmDff/VdJJEZ5yp2
         AmnCgXzsj3kbmeF/gJYcx5lT4G8NADWKi8KRBm9ZkoF4RTJ+jhwbfHn/97TGLKeFtHv1
         505A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E/SBnC7k7s+gyUl8RdyAj6nVYL4y6pk4li2IeqeZSKs=;
        b=RTVkGM74NlDX2vfFRzkpH1KrAfb9A9tUsa/PZtDGzsvy36S4CM9SJdiNcTKx5ckf+K
         kWShHbU1qz0Ky0F/2FsUQxEVUW5Ao2/56+9A7wK7SRd7lQRpgkoA1n9CogaT/jtJ0Z47
         cX54lCEDhGwrbdoYtsNDvw2D8GDJ9osnP1qUbnJPnlxjOrtwTJaAywOKnjX59I7bMjt3
         tE+ooa5ogJwmR9StYJRhr12CxV4+wP3vITQTtUz/LFQvj8+b7dvbGVhJulsKCj7xRjc0
         oi0NQ/KasxRd9+10hdFs7BcGN/7RbhrxBIP6lkcnYqcCGwlZuEUAZzMB5RdrOCPtHOMZ
         3E8w==
X-Gm-Message-State: AOAM533mfOnuV6fOo7b6gL11bcP5GKglpWDbpGVaOcVNbYw2akup6dxR
        08de28x7RzqqPAaKQ6yNxQoHIg+MZJokLjur4t1gk/5LIXQ=
X-Google-Smtp-Source: ABdhPJygPhh+FW0hY0cgT8ALMS5XzUedrIZaOvjxUYtEYbHKvnXZHapq9y/ObqWbktzqQhiL54lNytRa1I9wAs6vKIg=
X-Received: by 2002:aca:5d42:: with SMTP id r63mr2645689oib.94.1609927639332;
 Wed, 06 Jan 2021 02:07:19 -0800 (PST)
MIME-Version: 1.0
References: <CAFSh4UwMr7t+R9mWUCjdecadJL6=_7jdgagAQK6Y1Yj0+Eu0sg@mail.gmail.com>
In-Reply-To: <CAFSh4UwMr7t+R9mWUCjdecadJL6=_7jdgagAQK6Y1Yj0+Eu0sg@mail.gmail.com>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Wed, 6 Jan 2021 10:07:08 +0000
Message-ID: <CAFSh4UwAmR+sdfbdyxHRDnDr8r+TXxo2bvWtY3gmLAJekWc3Sw@mail.gmail.com>
Subject: Re: cBPF socket filters failing - inexplicably?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to note I have also reproduced this on a 5.10.0 kernel.

On Tue, Jan 5, 2021 at 1:42 PM Tom Cook <tom.k.cook@gmail.com> wrote:
>
> In the course of tracking down a defect in some existing software,
> I've found the failure demonstrated by the short program below.
> Essentially, a cBPF program that just rejects every frame (ie always
> returns zero) and is attached to a socket using setsockopt(SOL_SOCKET,
> SO_ATTACH_FILTER, ...) still occasionally lets frames through to
> userspace.
>
> The code is based on the first example in
> Documentation/networking/filter.txt, except that I've changed the
> content of the filter program and added a timeout on the socket.
>
> To reproduce the problem:
>
> # gcc test.c -o test
> # sudo ./test
> ... and in another console start a large network operation.
>
> In my case, I copied a ~300MB core file I had lying around to another
> host on the LAN.  The test code should print the string "Failed to
> read from socket" 100 times.  In practice, it produces about 10%
> "Received packet with ethertype..." messages.
>
> I've observed the same result on Ubuntu amd64 glibc system running a
> 5.9.0 kernel and also on Alpine arm64v8 muslc system running a 4.9.1
> kernel.  I've written test code in both C and Python.  I'm fairly sure
> this is not something I'm doing wrong - but very keen to have things
> thrown at me if it is.
>
> Regards,
> Tom Cook
>
>
> #include <stdio.h>
> #include <sys/socket.h>
> #include <sys/types.h>
> #include <arpa/inet.h>
> #include <linux/if_ether.h>
> #include <linux/filter.h>
> #include <stdint.h>
> #include <unistd.h>
>
> struct sock_filter code[] = {
>     { 0x06,    0,    0,    0x00 }  /* BPF_RET | BPF_K   0   0   0 */
> };
>
> struct sock_fprog bpf = {
>     .len = 1,
>     .filter = code,
> };
>
> void test() {
>     uint8_t buf[2048];
>
>     int sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
>     if (sock < 0) {
>         printf("Failed to open socket\n");
>         return;
>     }
>     int ret = setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &bpf, sizeof(bpf));
>     if (ret < 0) {
>         printf("Failed to set socket filter\n");
>         return;
>     }
>     struct timeval tv = {
>         .tv_sec = 1
>     };
>
>     ret = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
>     if (ret < 0) {
>         printf("Failed to set socket timeout\n");
>         return;
>     }
>
>     ssize_t count = recv(sock, buf, 2048, 0);
>     if (count <= 0) {
>         printf("Failed to read from socket\n");
>         return;
>     }
>
>     close(sock);
>
>     uint16_t *ethertype = (short*)(buf + 12);
>     uint8_t *proto = (unsigned char *)(buf + 23);
>     uint16_t *dport = (uint16_t *)(buf + 14 + 20);
>
>     printf("Received packet with ethertype 0x%04hu, protocol 0x%02hhu
> and dport 0x%04hu\n", *ethertype, *proto, *dport);
> }
>
> int main() {
>     for (size_t ii = 0; ii < 100; ++ii) {
>         test();
>     }
> }
