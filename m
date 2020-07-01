Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379F210CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgGANzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 09:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbgGANzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:55:48 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC66D207BB;
        Wed,  1 Jul 2020 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593611747;
        bh=9ZMBOmEsNNbmda5wTJJt2w3hw5mgWBnq6kQdLlk1rMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McqG19/F06d2c71ulZIQP7lyRRslCz3AfxniwHs4SxukSr0Uwl28n/tEM1ihTh7fK
         ocb0+p3URXbtNwodO8D6Zd+cSWmwmNIq9VS2iB0w6EWGt4stNKeWjLCrK0OgVDpe3q
         DKdckN4ohzZcf7e75slrPRuQn5amfPOJEamQ4z3c=
Date:   Wed, 1 Jul 2020 19:25:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: zynqmp: Fix unused-function compiler warning
Message-ID: <20200701135543.GA2599@vkoul-mobl>
References: <20200701090438.21224-1-tklauser@distanz.ch>
 <20200701131902.GC27013@pendragon.ideasonboard.com>
 <20200701133643.GZ2599@vkoul-mobl>
 <20200701134443.GE27013@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701134443.GE27013@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 01-07-20, 16:44, Laurent Pinchart wrote:

> > How about marking it as __maybe_unused instead?
> 
> I don't mind either, I'll let Tobias decide, but his patch seems fine,
> is there a drawback in his approach ? If it's just a matter of personal
> preference, I'd rather not require a v2.

__maybe_unused is the preferred way to do as Documented in
Documentation/process/coding-style.rst and makes code look neater..

Thanks
-- 
~Vinod
