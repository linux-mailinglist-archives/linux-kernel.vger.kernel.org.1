Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E002F8FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 00:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbhAPXkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 18:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbhAPXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 18:40:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80982C061574
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 15:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=AoD5f7YvM8N8YtJEZFUziWMNgh5j6/Uyf7sbiChOgO8=; b=kmOJIaGBaVlx8P+pd1wpWhTBrd
        Ee4avyLWlwlmOalxRZ2TKPG2TdUIt0HY+hkfHFqInP70NeqaOHpHP98UJzjNhctqFVTXAkLhIXJr3
        bXuNMgOs/iOurl5viCOfYdhPcvyXrujMuuNj8SVBRJkvXvEkrk0lBQmKjnh1dckOVhNQFgJysLExp
        9ey5eoOsXAJuHe20BOVGexBO4fvVmOj/M9awkUgGYjKVZqcfJ2bNtIWCMv/6q4FYy3eWie9khWa/v
        K19Uh+Ax7Y6pfTth/FavHxL7JwUX2c4IVwzFRq0nYWc/gtdzcFuaKxySDfzQ5K6ls/q0/wxz2eD/r
        4PB/wMoA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0vA9-0005xt-O3; Sat, 16 Jan 2021 23:39:22 +0000
Subject: Re: Missing param value! Expected 'rw=...value...'
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <27b2e02f-0840-2686-7aad-16274519dcdc@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb54e349-7147-0a1f-a349-1e16ba603fce@infradead.org>
Date:   Sat, 16 Jan 2021 15:39:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <27b2e02f-0840-2686-7aad-16274519dcdc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/21 3:07 PM, Heiner Kallweit wrote:
> Since 60b7cab23e5e ("proc_sysctl: fix oops caused by incorrect command parameters.")
> I'm getting the following warning: Missing param value! Expected 'rw=...value...'
> AFAIK param rw doesn't require a value. That's what my command line looks like:
> Command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=/dev/sda2 rw
> 

"rw" isn't a sysctl, so it looks like that added test is too early in
that function.


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
