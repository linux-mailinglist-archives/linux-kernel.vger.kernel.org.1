Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40E1AFC3C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgDSQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 12:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDSQy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:54:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA18214D8;
        Sun, 19 Apr 2020 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587315296;
        bh=K6oNZ/Tq9ApkI9jzF10v8SshEFMWzWxV6luzrI0dmTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEdsYZp52eMri9BlPl3nqoBrXXz71s/GOxAn4PdYKcz19YNzGhobTv/xAwGA1f1N5
         PLxptd5FzYoY5w2m2Wqw9E1XIwZ31ijzo2F/mx4siguu6/3pl7KxTNo3TDa7+K4rqE
         9oHM9so7wv7PLSNJ0Y7lnmHImmaZ15ZH3N4/AXBQ=
Date:   Sun, 19 Apr 2020 18:54:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fixed broken microcode early loading on 32 bit
 platforms because it always jumps past cpuid in sync_core() as data
 structure boot_cpu_data are not populated so early in boot. This is for 4.4.
 Should be done for 4.9 too
Message-ID: <20200419165453.GB3697654@kroah.com>
References: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
 <20200419162943.3704-2-evalds.iodzevics@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419162943.3704-2-evalds.iodzevics@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 07:29:43PM +0300, Evalds Iodzevics wrote:
> ---
>  arch/x86/include/asm/microcode_intel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your subject line is really confused :(

