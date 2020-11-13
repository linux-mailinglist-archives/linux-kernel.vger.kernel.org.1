Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144362B16FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKMINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgKMINE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:13:04 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27387217A0;
        Fri, 13 Nov 2020 08:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605255184;
        bh=uzHAiLbo+aC1ss3zjuPDQuBqsIryl2lKizi9018PHyk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IK6jsPcyOcr4aMCNj5/GPq39a3wDr8cQj5QvPLSw/FOy45seu0O0TNCvzTScIG0mu
         AzP38sj/boocBTzJxqp/h20mnZkNKdMOY1mD9zRlcJuEnHNuhbKXCOezo9gcaz0FBV
         LMIXMg1o+ibBnZvR5VwD+/LKsHSBbeZqoneVt984=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605062036-12735-1-git-send-email-weiyi.lu@mediatek.com>
References: <1605062036-12735-1-git-send-email-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v2] clk: mediatek: fix mtk_clk_register_mux() as static function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Fri, 13 Nov 2020 00:13:02 -0800
Message-ID: <160525518273.60232.13374675894733235790@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Fix" is a little strong. Maybe the subject should just be "Make
mtk_clk_register_mux() a static function".

Quoting Weiyi Lu (2020-11-10 18:33:56)
> mtk_clk_register_mux() should be a static function
>=20
> Fixes: a3ae549917f16 ("clk: mediatek: Add new clkmux register API")
