Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139F128C16D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbgJLT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387974AbgJLT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:26:16 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522602074A;
        Mon, 12 Oct 2020 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602530776;
        bh=Z2F7hT/rtiFpKHrOdbWSil4FwSFmNrhQsk/IQB1RaAo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lgced3+Zq1zK+bGA+HzuCC8nqbByms2HTt6BvjcsUEyPmQTMZov/m7G0uWD95MPpq
         ABrfmQGy2MG35o8TFaYHl587ST1XUpOgjCKjllIHdpdpHR0tr6ivSnYGAjla672Ay9
         uft2uj8S8m2ZIwalJ0BygYEvs0A6yT2Ms3tx295s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ba7319ab47bc7e80a57667f700ab677ceaa3ca8c.1602245659.git.mchehab+huawei@kernel.org>
References: <cover.1602245659.git.mchehab+huawei@kernel.org> <ba7319ab47bc7e80a57667f700ab677ceaa3ca8c.1602245659.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: fix broken doc refs due to yaml conversion
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?utf-8?q?J=C3=A9r=C3=B4me?= Pouiller 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Mon, 12 Oct 2020 12:26:15 -0700
Message-ID: <160253077510.310579.8020430999414158134@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mauro Carvalho Chehab (2020-10-09 05:15:30)
> Several *.txt files got converted to yaml. Update their
> references at MAINTAINERS file accordingly.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
