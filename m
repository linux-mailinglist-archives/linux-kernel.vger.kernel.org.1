Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8282A3C8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgKCGF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:05:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14340 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgKCGFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:05:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0f3280003>; Mon, 02 Nov 2020 22:05:28 -0800
Received: from [10.25.99.190] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 06:05:21 +0000
Subject: Re: [PATCH v3 0/3] dt-bindings: Convert graph bindings to json-schema
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <kuninori.morimoto.gx@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <20201102203656.220187-1-robh@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <9a428e64-27ad-39d7-9e05-abcc7ce49429@nvidia.com>
Date:   Tue, 3 Nov 2020 11:35:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102203656.220187-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604383528; bh=bFMxqKpNm1Rmm5wYbOGBWAFW0dBsLb7bbGwGavTI0bU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=SBpEpcNvterN8bS5CVKenBtobx9I2HdW4S09mqp1tYLIJwJNCMTftl2khhecYfN5R
         Rmyo5W8xNhaJWU/RbLslnZjFpnnDqm0TpgevhXd3vT7UixKqC8RhNdkYzyWBC5z1Qd
         I2wmd4JqJbcodmZPEDb7HDXDaDo0X9YhJ0cXRFNJpns61omZKNx/6+k5fM13NyOSwY
         UY4R5U4FI3Zm1WyfN+OkClbADvMKAvwWSlj4Xk4YYfl7kl6r2+R96w27Fj3/0r5pX+
         9vTlVgQosQJBlpdw7f1lOcktvzMXpITvponbIDWx0berK6RlVrtK+V09TPTTnmEW3Q
         gVONAJu5qmiTQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Sameer, I wanted to experiment with what the interface for graph users
> looks like, so I've tweaked your patch a bit and converted 2 users.

Thanks for the update and help.
