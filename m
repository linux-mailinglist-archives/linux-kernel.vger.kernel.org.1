Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED921A05F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGIM4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 08:56:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34470 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGIM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:56:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4B2bm12FFjz1qs0p;
        Thu,  9 Jul 2020 14:56:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4B2bm11cqDz1qr5G;
        Thu,  9 Jul 2020 14:56:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id WbtLDCXXAu1f; Thu,  9 Jul 2020 14:56:48 +0200 (CEST)
X-Auth-Info: cotWZ0zpxsn8DUJfFI53qGsRrQ2NdPQ5BXZYO0cnJnQ1Lm0koGAWi3Bhr/VBwbkG
Received: from igel.home (ppp-46-244-184-194.dynamic.mnet-online.de [46.244.184.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  9 Jul 2020 14:56:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id EE4F82C0B9F; Thu,  9 Jul 2020 14:56:47 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: printk of non NULL terminated strings ?
References: <4436dd281299b46f431ad1707c5de42af45ea4f7.camel@infinera.com>
X-Yow:  I want a VEGETARIAN BURRITO to go..  with EXTRA MSG!!
Date:   Thu, 09 Jul 2020 14:56:47 +0200
In-Reply-To: <4436dd281299b46f431ad1707c5de42af45ea4f7.camel@infinera.com>
        (Joakim Tjernlund's message of "Thu, 9 Jul 2020 12:31:14 +0000")
Message-ID: <87h7ugu9rk.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 09 2020, Joakim Tjernlund wrote:

> Is there a format (or other function) that lets me
> print strings without an \0 terminator using an explicit length arg instead?

Use the precision.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
