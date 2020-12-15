Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E172DB3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgLOSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbgLOSo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:44:57 -0500
Date:   Tue, 15 Dec 2020 18:44:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, will@kernel.org, robh+dt@kernel.org,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: Re: [PATCH 0/6] Expose RPi4'd bootloader configuration
Message-ID: <20201215184407.GA44849@C02TF0J2HF1T.local>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215155627.2513-1-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 04:56:20PM +0100, Nicolas Saenz Julienne wrote:
> Soon to be released versions of RPi4's firmware will take of care
> passing their bootloader's configuration to the OS by copying it into
> memory and creating a reserved memory node in the board's DT. In order
> to make use of this information, this series introduces a new generic
> nvmem driver that maps reserved-memory nodes into nvmem devices.
> 
> An alternative approach, less nice IMO, would be to create a
> platform-specific 'soc' driver.

What kind of information is this and how would the kernel use it?

-- 
Catalin
