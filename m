Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFDD23CD82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgHERgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 13:36:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49706 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgHERdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:33:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 075BjXds061534;
        Wed, 5 Aug 2020 06:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596627933;
        bh=oLXOtVGM0XldeErZ7lnDxDWT67udBtkfwHx5aUoMNbM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O90REE9dvBBeRL3oeN+FvYeFbekVdTViw1Uo2UfwrOrorIcFFqlRZPLtTde2wOXII
         ZG//xv3T3axRuyxgvSPsXQHvK0+1uZv++K1ep+BN+8AUbHUxcaRyRHZcC1IvaLw2Ul
         eDD25IQdOFw2pbsu+nO3H+XdWzY8FVkdcrMEpHW4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 075BjXW3063923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Aug 2020 06:45:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 5 Aug
 2020 06:45:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 5 Aug 2020 06:45:33 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075BjViD085971;
        Wed, 5 Aug 2020 06:45:31 -0500
Subject: Re: [PATCH] drm/omap: fix spelling mistake "propert" -> "property"
To:     Colin King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200805102015.14891-1-colin.king@canonical.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <ad33a2ea-3596-0b4c-35ae-ca8eb76d1a3f@ti.com>
Date:   Wed, 5 Aug 2020 14:45:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805102015.14891-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


