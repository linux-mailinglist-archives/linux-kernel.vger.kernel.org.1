Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3250E2A7529
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgKECBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKECBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:01:16 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EDD20719;
        Thu,  5 Nov 2020 02:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604541676;
        bh=RFc8d0y83E3PgGn9wJI96kwAEwvdlKbg2Wq2RgVOFoM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MBDmYvNljcbupjMZatW7V6L3jaFdSM0Q72QaGGvAWGQYIkErP3tvcpPd5ANsOpoVy
         oy9AcWJUcBqIK0MG2nxyepckjlDF2r9MbIOVgADXZSkiXf0jt4nV9AFhKDje9hbvLr
         tT66qE2f+WjVf/cbxvkfiQW/XtdyUpLk8qOh4bQw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b2336f3f3cdfe6e1a2d3a7a056ab7ccc7a81b945.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org> <b2336f3f3cdfe6e1a2d3a7a056ab7ccc7a81b945.1603469755.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v3 38/56] clk: fix a kernel-doc markup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Wed, 04 Nov 2020 18:01:14 -0800
Message-ID: <160454167435.3965362.9994740112660959961@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mauro Carvalho Chehab (2020-10-23 09:33:25)
> clk_get_duty_cycle -> clk_get_scaled_duty_cycle
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Applied to clk-next
