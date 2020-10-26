Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4229877A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422066AbgJZHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395145AbgJZHeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:34:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403E5222EA;
        Mon, 26 Oct 2020 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603697660;
        bh=99RlIUMGDaEtFWs2LbJPS65lPnOlR6QKOvR197ecHY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvECUt/uEYPXwlH9x3jLT8Mg2oxQCKrHWTPrNO0UGrEWryOHZRIV1lPa+pFS5SehA
         4XcC+XhOCvh6nC9MO/rkUrEGOztWY6ZRJW6+FQYh5ZWNpUxrnV79bM53+pg2dMbOda
         sPvlcUg2RnpLDo7DhJxBobGjoBqCeGwm0mW0FxKQ=
Date:   Mon, 26 Oct 2020 15:34:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: imx8mq-librem5: align GPIO hog names
 with dtschema
Message-ID: <20201026073413.GF9880@dragon>
References: <20200920195749.26952-1-krzk@kernel.org>
 <20200920195749.26952-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920195749.26952-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 09:57:48PM +0200, Krzysztof Kozlowski wrote:
> dtschema expects GPIO hogs to end with 'hog' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
