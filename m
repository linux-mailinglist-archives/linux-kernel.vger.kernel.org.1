Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68682B0082
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 08:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgKLHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKLHtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:49:11 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00542221FE;
        Thu, 12 Nov 2020 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605167350;
        bh=OsJVUcmEyZp5GjkeU03zDOuVPcqxAlznrpZOLPDkMSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRLKYPMkm3G/rR5Yen5XRYfn4/tSn8SiEyU+40K5Gw8mpvRGa8QUfTx00boapZ4kL
         svBZvWmUcDtzjRSBF+tlNajbRKu2wqSB0bBHvO+NljD/es5M7K4/+UeS4DRIMjB3s5
         VrkusVV4HtFyY/hAHYYfWDihYvRdJxPLPq1PnfFg=
Date:   Thu, 12 Nov 2020 08:50:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] w1: w1_therm: Rename conflicting sysfs attribute
 'eeprom' to 'eeprom_cmd'
Message-ID: <X6zpMRSLdAv6NoYV@kroah.com>
References: <20201112064931.8471-1-ivan.zaentsev@wirenboard.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112064931.8471-1-ivan.zaentsev@wirenboard.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:49:31AM +0300, Ivan Zaentsev wrote:
> Duplicate attribute 'eeprom' is defined in:
> 1) Documentation/ABI/testing/sysfs-driver-w1_therm
> 2) Documentation/ABI/stable/sysfs-driver-w1_ds28e04
> 
> Both drivers define an attribute: /sys/bus/w1/devices/.../eeprom
> with conflicting behavior.
> 
> Fix by renaming the newer one in w1_therm.c to 'eeprom_cmd'.
> 
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/lkml/20201029152845.6bbb39ce@coco.lan/
> Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
> ---
>  Documentation/ABI/testing/sysfs-driver-w1_therm |  2 +-
>  Documentation/w1/slaves/w1_therm.rst            |  2 +-
>  drivers/w1/slaves/w1_therm.c                    | 12 ++++++------
>  3 files changed, 8 insertions(+), 8 deletions(-)

Very nice, thanks for doing this, I'll go queue this up now.

greg k-h
