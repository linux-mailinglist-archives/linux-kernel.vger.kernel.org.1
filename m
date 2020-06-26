Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18820B2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgFZNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 09:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgFZNph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:45:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087CB207D8;
        Fri, 26 Jun 2020 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593179137;
        bh=iE3tzCAvbGL1rbktPt6yEr1J1jW46XJSCh5A37dUpCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjaOP2S48N4PiUtwTGuhQhSBT2SRLmd2NQBOGgleCQdl6+zShGXD9byTyziBJC/PR
         FUhDK1WY01BmAh1vNQr3bRVRZjeE2CwH3G9RROahCxUpk07Yqjm6uLex+r2YMf95mb
         J1Cnh579al409RgfizJSvV9RBEauGw4JCP6OMCgo=
Date:   Fri, 26 Jun 2020 15:45:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com
Subject: Re: [PATCH v4 8/8] staging: clocking-wizard: Delete the driver from
 the staging
Message-ID: <20200626134532.GA4095392@kroah.com>
References: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1593175304-4876-9-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593175304-4876-9-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 06:11:44PM +0530, Shubhrajyoti Datta wrote:
> Delete the driver from the staging as it is in drivers/clk.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
