Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6329D6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgJ1WSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731741AbgJ1WRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE90B246E4;
        Wed, 28 Oct 2020 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603886954;
        bh=8kOmEjZiFrehUn8/7MpuG001uMFWbRfFMOEgl1ikA18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H02cNAg8Te9ZBGshSHUpRXiVbKDk655VVD7ojc1ge4zDSuksLXmykW88XWUgtLlGp
         MMn8uKc3ZbpDY5LAFD1pJ2ZfP1CE3TgBraXUmT23bHMCZ5/A1v/2WzRY60TFsuFfHw
         jcsSg5rZ2fEmjdbCRgkA1subcbh76AYfMnfvbJLU=
Date:   Wed, 28 Oct 2020 13:10:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v11 00/10] *** TCPM support for FRS and AutoDischarge
 Disconnect ***
Message-ID: <20201028121006.GA2044275@kroah.com>
References: <20201020093627.256885-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020093627.256885-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:36:17AM -0700, Badhri Jagan Sridharan wrote:
> Hi all,
> 
> Addressed comments from Rob Herring for dt-bindings patches:
> - Added part number for the maxim chip to dt-binding and renamed the
>   file. Fixed it on the driver side as well with
>   usb: typec: tcpci_maxim: Fix the compatible string
> - new-source-frs-typec-current now uses u32.
> 
> Added Reviewed by tags from Heikki.

Patch 1 applied, I think you need to fix up 02 and resend the rest as
well.

thanks,

greg k-h
