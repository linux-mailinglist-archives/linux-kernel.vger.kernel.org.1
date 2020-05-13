Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5701D1B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbgEMQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 12:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgEMQzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:55:09 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A8E2065D;
        Wed, 13 May 2020 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388910;
        bh=jK0POYIL9Mor0rbRIC46pg4AavvAIViEOzMWk8fyDCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp+daNLgO3qQoIy2aYgOOLbLjNrwPmRNghNcwLpa8+yHA6GND5OcOQA0Xdm+uCHSH
         Z39la1TKwm8nG00KBWedYFiv92zhb2pFa84BG9q2XeQ0HQNcb7iFF7EigmAGH/4oSM
         rF4ARwqwohxHMSlQR9RJJ9WGjum15mEKDEWuKjYs=
Date:   Wed, 13 May 2020 11:59:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Replace zero-length array with flexible-array
Message-ID: <20200513165945.GO4897@embeddedor>
References: <20200507185050.GA13953@embeddedor>
 <1027665B-71AC-4BC1-A3DF-64B1A9475B31@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027665B-71AC-4BC1-A3DF-64B1A9475B31@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Wed, May 13, 2020 at 09:30:03AM +0200, Marcel Holtmann wrote:
> > ---
> > include/net/bluetooth/l2cap.h |    6 +++---
> > include/net/bluetooth/mgmt.h  |   40 ++++++++++++++++++++--------------------
> > 2 files changed, 23 insertions(+), 23 deletions(-)
> 
> the mgmt.h portion we already have in bluetooth-next tree. Can you send a version that just addresses l2cap.h. Thanks.
> 
> 

Sure thing. I'll send a patch for that, shortly.

Thanks
--
Gustavo
