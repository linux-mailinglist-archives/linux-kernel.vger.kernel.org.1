Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6121D7E33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgERQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 12:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgERQUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:20:31 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D391C20657;
        Mon, 18 May 2020 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589818831;
        bh=FsK0dVAzT2BpK4J726GyBc0EpiLYz4xxSWGk+QuxTNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUGFslC7tT1Yqz67zOU7tbO7Q50iICybVe6U601ySEhUCL1k6gj3qID6TTpW72xBm
         XlUpOLJIYxICkxmKq5zuVkm86kjeX0cGC/qP7OXe/tEX4/Y3UgvwY/sUvO0MIZfYGl
         MSCBPfZZkFb4uu6vvNb+X5Ta5MKK39AV+o667tw0=
Date:   Mon, 18 May 2020 11:25:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Replace zero-length array with flexible-array
Message-ID: <20200518162517.GB9868@embeddedor>
References: <20200507190549.GA15653@embeddedor>
 <20200518091613.GA2861@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518091613.GA2861@light.dominikbrodowski.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:16:13AM +0200, Dominik Brodowski wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied to pcmcia-next.
> 

Thanks, Dominik.

--
Gustavo
