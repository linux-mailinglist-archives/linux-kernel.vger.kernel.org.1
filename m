Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C395267D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 03:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgIMBcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 21:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgIMBca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 21:32:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B017321531;
        Sun, 13 Sep 2020 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599960750;
        bh=2OFoyzQtwNqmkKeq4GCenFVXI8J6w5aIkz/344iJnFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0Ag/E4rtidqAxPKVSWXNYTYtIgXM/iUx4QUo0vR/7kdD74qo6kNOSO55Wz/5LRUc
         nG9WWLD0EPgHXmncJOPtoz1+2cFYQ4ywKowmTYUeIIV3FYgIxdO1M5rMNVVIm/7g2l
         mNs0dA/PjK1BGil0AmbDeNVLbToFipS9vogPWI+I=
Date:   Sun, 13 Sep 2020 09:32:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ARM: dts: imx6qdl: tqma6: fix indentation
Message-ID: <20200913013224.GE25109@dragon>
References: <20200907080429.12496-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907080429.12496-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 10:04:27AM +0200, Matthias Schiffer wrote:
> The PMIC configuration is indented one level too deep.
> 
> Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

I change the subject prefix to 'ARM: dts: imx6qdl-tqma6:' and applied
all 3.

Shawn
