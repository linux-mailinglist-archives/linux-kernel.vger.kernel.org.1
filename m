Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A71B2FDAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbhATU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbhATN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:56:53 -0500
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jan 2021 05:50:11 PST
Received: from ellomb.netlib.re (unknown [IPv6:2001:912:1480:10::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412AFC061793
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:50:11 -0800 (PST)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by ellomb.netlib.re (Postfix) with ESMTPA id 878EA4A7F78D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mildred.fr; s=dkim;
        t=1611150016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=afw9qI/QopdCYcXS2MJqQmVd3vUyRHZ3IkSpWWWdk+g=;
        b=Br8b4903BhtCi3HNobFrKAL9qRGMmZE10UKIpL7m+wlH16oz/jDqkmEhzLocxsZ4+eas6L
        y0xxfLoQdUzqzRACZIQNOfZHaCZy9k5amigCWQnymam9V/347b6cR0UxiVa5CcoN1CrRgt
        ygbudAGIACBNOux5srbc87QkoLBkji0=
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Shanti_Lombard_n=c3=a9e_Bouchez-Mongard=c3=a9?= 
        <shanti20210120@mildred.fr>
Subject: More flexible BPF socket inet_lookup hooking after listening sockets
 are dispatched
Message-ID: <afb4e544-d081-eee8-e792-a480364a6572@mildred.fr>
Date:   Wed, 20 Jan 2021 14:40:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mildred.fr;
        s=dkim; t=1611150016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=afw9qI/QopdCYcXS2MJqQmVd3vUyRHZ3IkSpWWWdk+g=;
        b=czujUuD3buHv2yDstA+rCgneBK+UxHcpUk1xGDV55pvtkrjfWDCvF4C/0pf1+aVxGMmhDg
        KgByF9yPsDZz69ec9kvNLO299rFM4jhBg5SS7CqYUKzhigE0GebFdO6tFQdiYImFRDKmee
        Mya4xTxDTTHmmlUjOzSE0SA9TCZERoI=
ARC-Seal: i=1; s=dkim; d=mildred.fr; t=1611150016; a=rsa-sha256; cv=none;
        b=i04/G7xC9xGBUIlb4l6a4PTixrRRfL4i5vdfNfTR0fSqEBa0+zXUjw8KrClQ5NIcfYSHvG
        TJo2xHMd0p7rf1B4q6j0P4un1TmN94M2fY9uRvo5kTTi2h2ZvTlf1rbAMtN4yHgubXgZuU
        UPNEdC5oNRAp0XDep1eaMKqpCLKfI0A=
ARC-Authentication-Results: i=1;
        ellomb.netlib.re;
        auth=pass smtp.auth=mildred@mildred.fr smtp.mailfrom=shanti20210120@mildred.fr
Authentication-Results: ellomb.netlib.re;
        auth=pass smtp.auth=mildred@mildred.fr smtp.mailfrom=shanti20210120@mildred.fr
X-Spamd-Bar: /
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I believe this is my first time here, so please excuse me for mistakes. 
Also, please Cc me on answers.

Background : I am currently investigating putting network services on a 
machine without using network namespace but still keep them isolated. To 
do that, I allocated a separate IP address (127.0.0.0/8 for IPv4 and ULA 
prefix below fd00::/8 for IPv6) and those services are forced to listen 
to this IP address only. For some, I use seccomp with a small utility I 
wrote at <https://github.com/mildred/force-bind-seccomp>. Now, I still 
want a few selected services (reverse proxies) to listed for public 
address but they can't necessarily listen with INADDR_ANY because some 
other services might listen on the same port on their private IP. It 
seems SO_REUSEADDR can be used to circumvent this on BSD but not on 
Linux. After much research, I found Cloudflare recent contribution 
(explained here <https://blog.cloudflare.com/its-crowded-in-here/>) 
about inet_lookup BPF programs that could replace INADDR_ANY listening.

The inet_lookup BPF programs are hooking up in socket selection code for 
incoming packets after connected packets are dispatched to their 
respective sockets but before any new connection is dispatched to a 
listening socket. This is well explained in the blog post.

However, I believe that being able to hook up later in the process could 
have great use cases. With its current position, the BPF program can 
override any listening socket too easily. It can also be surprising for 
administrators used to the socket API not understanding why their 
listening socket does not receives any packet.

Socket selection process (in net/ipv4/inet_hashtables.c function 
__inet_lookup_listener):

- A: look for already connected sockets (before __inet_lookup_listener)
- B: look for inet_lookup BPF programs
- C: look for listening sockets specifying address and port
- D: here, provide another inet_lookup BPF hook
- E: look for sockets listening using INADDR_ANY
- F: here, provide another inet_lookup BPF hook

In position D, a BPF program could implement socket listening like 
INADDR_ANY listening would do but without the limitation that the port 
must not be listened on by another IP address

In position F, a BPF program could redirect new connection attempts to a 
socket of its choice, allowing any connection attempt to be intercepted 
if not catched before by an already listening socket.

The suggestion above would work for my use case, but there is another 
possibility to make the same use cases possible : implement in BPF (or 
allow BPF to call) the C and E steps above so the BPF program can 
supplant the kernel behavior. I find this solution less elegant and it 
might not work well in case there are multiple inet_lookup BPF programs 
installed.

With this e-mail I wanted to spawn a discussion around that and possibly 
take on the implementation. I never did any kernel development before 
but you must start by something, and I believe this is a rather simple 
improvement (duplicate already existing hooking, just a little bit lower 
in the function). I might not be able to deliver this very quickly 
either because I have limited time for this and I need to learn kernel 
development but I'm ready to take on this task.

Thank you for your time

Shanti


