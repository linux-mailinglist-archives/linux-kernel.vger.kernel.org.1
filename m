Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FC2A8995
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgKEWOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:14:53 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:44125 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:14:53 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5754F200006;
        Thu,  5 Nov 2020 22:14:51 +0000 (UTC)
Date:   Thu, 5 Nov 2020 23:14:51 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudius Heine <ch@denx.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>,
        Johannes Hahn <johannes-hahn@siemens.com>
Subject: Re: [PATCH 0/2]  Adding I2C support to RX6110 RTC
Message-ID: <20201105221451.GH1034841@piout.net>
References: <20201104102629.3422048-1-ch@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104102629.3422048-1-ch@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Claudius!

It has been a while ;)

On 04/11/2020 11:26:27+0100, Claudius Heine wrote:
> Hi,
> 
> this patch introduces I2C support to the RX6110 RTC driver and also adds
> an ACPI identifier to it.
> 
> Since we are also pushing the coreboot changes for the ACPI table
> upstream in parallel, we are free to name this ACPI entry however we
> like it seems. So any feedback on that would be welcome ;)
> 

I don't care too much about ACPI so if you are really looking for advice
there, I guess you should ask seom of the ACPI guys (but I guess you are
free to choose whatever you want).

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
