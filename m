Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FEF2579DB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHaM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 08:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgHaM65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:58:57 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA0F2068E;
        Mon, 31 Aug 2020 12:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598878736;
        bh=46T9ACjOA3OBVoOMKuukh3GL6aUQVcEmNp7H0S2NQT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMz+zQsrdaMFWdLBBjfXPagW8bur+SdvM4hkuGrmDJKzSfYQiSiqa8xDgXLhQJ09V
         GzK6RCDZ+Y2jJX1sJwxtbaJQIPKP1m6wxCDqlnYtCAeVJNPuw/cdzdHyLYsxmIKV6C
         EnnYW7yYRfKrNdY0B4nVlV3dWioMlQhVKCEr2xVE=
Date:   Mon, 31 Aug 2020 18:28:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH] phy: Move phy-rockchip-dphy-rx0 out of staging
Message-ID: <20200831125852.GR2639@vkoul-mobl>
References: <20200825220710.634106-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825220710.634106-1-ezequiel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-20, 19:07, Ezequiel Garcia wrote:
> There is no need for this driver to be in staging.
> Let's promote it!

Applied, thanks

-- 
~Vinod
