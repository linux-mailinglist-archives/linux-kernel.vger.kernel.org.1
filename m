Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB42FAD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbhARWgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbhARWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:36:06 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:35:24 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 15so19260175oix.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uxOEzX6xXP0i86Zj4ffh0rEXkxpSz7Uyd5uHaD8vEGU=;
        b=BRswJff75AyPjfV0YcmL0ZA1yafJNc1o3ZU3zocr+S6bajHTDKHiwu6c0ec7wqfxCT
         1asM+mm0p6tKS6HysoNsIgQj7qGn5bKAXTfp9LVN9DiXmSfR7eAa3t+op+SyKm78+0CQ
         S8jjD311EWPaph+jkPO5ZtWbyYyJsWvj13nwYwAtc/oDA238GbKEPGwwdZHeqtoQ0ApP
         YOl1h77827CZ9U7UYtoUyDgYoOR9v5Q2OPv9srvTLopwUaQMLHscZkhdycWLasWaZKVj
         ksy3UG531cj9k2tm2M3okHA3yVUvq8xFUWiqMTE+iurUPRpash4+aa5ve5oGcGSppvFI
         aX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uxOEzX6xXP0i86Zj4ffh0rEXkxpSz7Uyd5uHaD8vEGU=;
        b=F0kAbWphOgQWApmzK1EigmbYIkRmWgZDZDDt3Ob4jXDWBaep3YfBo9DbLOR9A+28hh
         JdsjrpJFXkz9yJ2CKmhNokkDkTSLYsLv46Po8OZY9Hx1UUXAXH0/d9PFWXF5fNAousBZ
         lX6WnJ5i5ZQpoJhohvwv4c6rkRLDLsRfYpXhnxvKXSQYHOgzwyfpqd+lCS9eNmCIIn8M
         UVIQNh31i1iYF87alMZxxklPpDrHByUCgsgz51X5nfDQChMkZizbL7vUCzevtG+48w6I
         GFnKP83ij724OToCDUZ/SG7BgUiGv6y5VF534Myy2xk+kwXJ/1sI98Kdhp3PLKOBcqEy
         YNIw==
X-Gm-Message-State: AOAM532YU2hpNNVFUH+Ke46G2as9il8bDMmW5XSTR//7BGUINDcx01KU
        Nf+YWcDNNc9gh5UaPYEQUoqY67hRhfg=
X-Google-Smtp-Source: ABdhPJwwimsc/M/H7Sh9xCzJfkKEkZpoT1EhFKTTi5uhLgSsb9lOeqSYhRMwKcPc+PA8nG6i18xvbg==
X-Received: by 2002:aca:eb42:: with SMTP id j63mr924737oih.20.1611009323347;
        Mon, 18 Jan 2021 14:35:23 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13sm4035994oti.65.2021.01.18.14.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jan 2021 14:35:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Jan 2021 14:35:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc4
Message-ID: <20210118223520.GA193902@roeck-us.net>
References: <CAHk-=wjGqX0BFV0eH9R=9m2Xezib0w8Ty2zEc6XDJ73zNRPuPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGqX0BFV0eH9R=9m2Xezib0w8Ty2zEc6XDJ73zNRPuPQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 04:56:46PM -0800, Linus Torvalds wrote:
> Things continue to look fairly normal for this release: 5.11-rc4 is
> solidly average in size, and nothing particularly scary stands out.
> 
> In the diff itself, the new ampere modesetting support shows up fairly
> clearly - it's one of those hardware enablement things that should be
> entirely invisible to people who don't have that hardware, but it does
> end up being about a fifth of the whole rc4 patch.
> 
> If you ignore that oddity, the rest looks pretty normal, with random
> patches all over, and a lot of it being quite small. All the usual
> suspects: drivers (gpu, sound, rdma, md, networking..) arch updates
> (arm64, risc-v, x86), fiesystems (ext4, nfs, btrfs), core networking,
> documentation and tooling. And just random fixes.
> 

Here are the test results:

Build results:
	total: 153 pass: 151 fail: 2
Failed builds:
	arm64:allmodconfig
	ia64:defconfig
Qemu test results:
	total: 430 pass: 428 fail: 2
Failed tests:
	arm:raspi2:multi_v7_defconfig:bcm2836-rpi-2-b:initrd
	arm:raspi2:multi_v7_defconfig:sd:bcm2836-rpi-2-b:rootfs

Same old ...

Guenter
