Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7872F4ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbhAML6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbhAML6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:58:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9926A22CE3;
        Wed, 13 Jan 2021 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610539041;
        bh=HXlq4vPxrQ7OwlDTgqLZcX4XBL6fIDTx1J5HRUHdMm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ3LPFEJzFOU3BfNJwB9EK9K5a8oCpsavtfos6cQFdBekPHC4ZlEXUGurCHoJg1Og
         NtzgciGoNcDP3HaDqIzqPN8GA6y18Z+giqgVzYWS9esCYgiuxUmVMI7860eBPVHDLB
         NMI5+uBrte3/4paV9buokXMqnrNwIPqaCYEFtLxnHAubu9RlsqN/ntEuMz5hMjbbtO
         1WKvuwFlQ4Ka1dKi1hA5JmRxvIsnr4DYMu6St2h3r+wLGYdQEFHcYR0hrcjclW8i4u
         l5jxkeMvjBKrDm54TZoI3s/zNaVf9Z+m4W5rG0Sc7OBZ4n2RHw/eDu/bnEj1gWPCrs
         6M0ACHSa2B7lg==
Date:   Wed, 13 Jan 2021 17:27:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] phy: phy-brcm-usb: improve getting OF matching data
Message-ID: <20210113115716.GF2771@vkoul-mobl>
References: <20201216143305.12179-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201216143305.12179-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-20, 15:33, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Use of_device_get_match_data() helper to simplify the code
> 2. Check for NULL as a good practice

Applied both, thanks

-- 
~Vinod
