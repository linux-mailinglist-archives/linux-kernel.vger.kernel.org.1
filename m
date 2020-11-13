Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371FC2B171A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKMISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgKMISc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:18:32 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B12217A0;
        Fri, 13 Nov 2020 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605255512;
        bh=VqAcOJARE/ARF3+rgOl0jPiFyZV2srAdgBb54LlOUKI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=moQli1n8WvVXp0u+0E1prsHRGdwX253VUxrt95Tf7/ekfNd7LFhrmObCvJOCIy6uw
         WGVSp2mGQipXYICo34+AV0hYf6h1nbiv1qLtuEpXm4rBM2dHNRmxEJTbp7UklzAajN
         TpFwFlOkYSj2cEADMAN3vjvnXcr1SgXCXukc1pCs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201104165631.22295-1-digetx@gmail.com>
References: <20201104165631.22295-1-digetx@gmail.com>
Subject: Re: [PATCH v1] clk: Add enable-state column to clk summary
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dmitry Osipenko <digetx@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 13 Nov 2020 00:18:30 -0800
Message-ID: <160525551074.60232.7613044083282105115@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2020-11-04 08:56:31)
> Add "enable state" column to the clk summary. It's handy to know actual
> hardware state of all clocks for debugging purposes. In conjunction with
> clk_ignore_unused, this tells us what unused clocks are left on after
> bootloader without disabling the clocks.

Should it be called "boot state" then? That idea sounds OK to me.

> It's also s useful debugging

Stray 's' here.

> information for cases where firmware touches clocks.

Care to explain more? Presumably you mean when firmware is modifying clk
state without notifying the kernel? In which case it should be called
"hardware enable" or something like that and be a "Y/N/?" value
depending on if the value can be read or not and if it is enabled or not?

>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
