Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690A5271EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIUJRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:17:08 -0400
Received: from foss.arm.com ([217.140.110.172]:39714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgIUJRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:17:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35C330E;
        Mon, 21 Sep 2020 02:17:07 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FB763F718;
        Mon, 21 Sep 2020 02:17:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] drm/panfrost: add Amlogic integration quirks
To:     Neil Armstrong <narmstrong@baylibre.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200916150147.25753-1-narmstrong@baylibre.com>
 <842c31f7-3b59-6442-d4ca-c5dcc2317a04@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <119253ab-a677-8f1c-75c2-2005ca38dbee@arm.com>
Date:   Mon, 21 Sep 2020 10:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <842c31f7-3b59-6442-d4ca-c5dcc2317a04@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 08:52, Neil Armstrong wrote:
> Hi Steven, Rob,
> 
> Should I send a v3 with the commit log fixes ?

No need, I've fixed it up and pushed to drm-misc-next.

Thanks,

Steve
