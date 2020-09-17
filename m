Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA826DC54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgIQNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:02:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37986 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgIQNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:01:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HD0Yrc059673;
        Thu, 17 Sep 2020 08:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600347634;
        bh=228i3kO/ePj4BLGku9Pm9IqvyA00dorq9WbjfzFVaQ4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hK1ItdSApIqf0Ze7IciwXSSrujBEszcNjhN7MeBimRALTflBfYIHhgEtY788X4zO7
         jyyHus7bmAiHy5p7spvohl2zM11uUq3Ebg8ROQHAHBuynwXJSimAzMDlbu17rxG/Yi
         YsQpqZCm3q3+HxQPKuEfKCKRmiFmFvqMWXb8vzDc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HD0YYH026740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 08:00:34 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 08:00:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 08:00:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HD0XfG057556;
        Thu, 17 Sep 2020 08:00:33 -0500
Date:   Thu, 17 Sep 2020 08:00:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Roger Quadros <rogerq@ti.com>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
Message-ID: <20200917130033.5totdf6mdg3lbbmq@akan>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
 <d8b8c070-577f-f778-e595-58517ffce6e3@axentia.se>
 <20200917122703.ojuzn6b3tvqbnssc@akan>
 <02d57a88-ba7a-5944-8053-8f4ad03242d2@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02d57a88-ba7a-5944-8053-8f4ad03242d2@axentia.se>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:53-20200917, Peter Rosin wrote:
[..]
> I do not have a tree and dt-patches should normally not go *through* me.
yep. 
> But I'd still like to see what's happening.

> I did not realize this was going to cause a *lot* of churn in the dt
> files. How bad can it be when the file is new in this cycle? And is it
> worth it? But it seems you all see problems with the current naming and
> in that case it must surely be better to fix it early?

yes - I think I can figure it out.
> 
> And if it's a lot, maybe it needs to be more than one patch? I get the
> feeling this will need to be taken care of by someone other than me,
> because I'm just the maintainer of a very small subsystem and I don't
> normally have to deal with "big" issues involving several trees. I would
> be a bottleneck.

No a pain, I think I can help get it through, may be, I worry too much..
Lets see how the cleanup series looks like.

Roger: I am not touching the j7200 series till we cleanup j721e as
discussed in this thread. please use 5.9-rc1 as your baseline for
cleanup. Once available, we can figure out how to get 5.10-rc1 staged
items later. Window is narrowing rather soon, so appreciate a quick
cleaup :).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
