Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645F626D763
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIQJIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgIQJIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:08:40 -0400
Received: from localhost (unknown [84.241.193.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C407B206BE;
        Thu, 17 Sep 2020 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600333720;
        bh=pfRjencQKoxskaAAtPqHxpRXZ6k23r+Ls14eGHb5O2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQIozQ3fh7SyhZ0bPPVe4QJK81EHK8R20joD17b+vBQGWKMhgcTndtFGDOxxx4l4E
         r+T685u6Ix2aeiFy//HUhgn7l5m39KiBJqkWvL65IReQfsjx6Xc2edgQ4Pg/6LBFZb
         484ox+KdENcI55P1US510oudyEOjC/KO1etiFZx4=
Date:   Thu, 17 Sep 2020 11:08:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] coresight: next v5.9-rc5
Message-ID: <20200917090835.GB51699@kroah.com>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:17:21PM -0600, Mathieu Poirier wrote:
> Good morning Greg,
> 
> Here are the CS patches I'd like to see included in the v5.10 merge window.
> There might be a part two but I'm not sure yet.

Hopefully the "make things a module" gets fixed up to make it there :)

I'll apply this later today, thanks!

greg k-h
