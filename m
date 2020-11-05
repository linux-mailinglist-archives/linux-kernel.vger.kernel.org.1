Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14382A789D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgKEIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:12:43 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CEC0613CF;
        Thu,  5 Nov 2020 00:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u7VceP9EIJyP1WdZq41UI9GffxXizeWBZW8ZyCMQqJI=; b=ins9tDVYC0pdDkTd82t93yaiS3
        cN/1e+7/utKFGrIsTmEteckzrIZ0J50omwL3zqfB3uwZ4IvBh+gfzsB7nUUpQY/1zfVAX6lCsg0q6
        oc3xx7s4PCXUHSIkWcNF0w8V35NOLmZveco/G3UAizP7Jh5CJ206xm/0lz5dWLnv0eQA=;
Received: from p200300ccff0ddc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kaaNh-0005Nz-II; Thu, 05 Nov 2020 09:12:29 +0100
Date:   Thu, 5 Nov 2020 09:12:28 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
Message-ID: <20201105091228.128624ba@aktux>
In-Reply-To: <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
References: <20200930105442.3f642f6c@aktux>
        <20200930164446.GB219887@roeck-us.net>
        <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
        <20201002002251.28462e64@aktux>
        <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
        <20201006090226.4275c824@kemnade.info>
        <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
        <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
        <20201104142057.62493c12@aktux>
        <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
        <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
        <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
        <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
        <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
        <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 18:26:24 +1100
Brad Campbell <brad@fnarfbargle.com> wrote:

> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()") introduced
> an issue whereby communication with the SMC became unreliable with write
> errors like :
> 
> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.378621] applesmc: LKSB: write data fail
> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.512787] applesmc: LKSB: write data fail
> 
> The original code appeared to be timing sensitive and was not reliable with
> the timing changes in the aforementioned commit.
> 
> This patch re-factors the SMC communication to remove the timing 
> dependencies and restore function with the changes previously committed.
> 
> v2 : Address logic and coding style
> 
> Reported-by: Andreas Kemnade <andreas@kemnade.info>
> Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
> 
Still works here:
Tested-by: Andreas Kemnade <andreas@kemnade.info> # MacBookAir6,2
