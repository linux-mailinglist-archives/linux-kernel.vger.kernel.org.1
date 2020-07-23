Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE922A4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 03:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbgGWBtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 21:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgGWBtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:49:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85E22071A;
        Thu, 23 Jul 2020 01:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595468964;
        bh=Nmqte8bweK+QD9+SwQumY88j2R8RrE+EWxABzrIMfT4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cAbgm0XyX3ZFNdD75o/5JmOlsjYFGJKKE3YuR9/7MaqajEH6igfAOGsNaBeotsbMS
         Qd/Q6I8QoRrNmQKE43WCk3JEsl8lFfNfcM3xVfDLEeEZGhsPAcbDD+GfilLJVAG/qv
         vqEhWc6UpUaVVH4shxERWFyWU+sReO54YYFArSC4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200721164655.422-1-luca@lucaceresoli.net>
References: <20200721164655.422-1-luca@lucaceresoli.net>
Subject: Re: [PATCH v3 1/4] dt-bindings: clk: versaclock5: fix 'idt' prefix typos
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Wed, 22 Jul 2020 18:49:24 -0700
Message-ID: <159546896402.3847286.10939445139729414539@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2020-07-21 09:46:52)
> 'idt' is misspelled 'itd' in a few places, fix it.
>=20
> Fixes: 34662f6e3084 ("dt: Add additional option bindings for IDT VersaClo=
ck")
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> ---

Please use a cover-letter for multi-patch series.
