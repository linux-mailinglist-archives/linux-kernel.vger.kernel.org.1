Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4D1A1930
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 02:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDHAWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 20:22:48 -0400
Received: from gentwo.org ([3.19.106.255]:48778 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDHAWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:22:48 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 2956F3F948; Wed,  8 Apr 2020 00:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 2868F3F946;
        Wed,  8 Apr 2020 00:22:47 +0000 (UTC)
Date:   Wed, 8 Apr 2020 00:22:47 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Qiujun Huang <hqjagain@gmail.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slab_common: Fix a typo in comment
 "eariler"->"earlier"
In-Reply-To: <20200405160544.1246-1-hqjagain@gmail.com>
Message-ID: <alpine.DEB.2.21.2004080022100.3215@www.lameter.com>
References: <20200405160544.1246-1-hqjagain@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020, Qiujun Huang wrote:

> There is a typo in comment, fix it.
> s/eariler/earlier/


Acked-by: Christoph Lameter <cl@linux.com>
