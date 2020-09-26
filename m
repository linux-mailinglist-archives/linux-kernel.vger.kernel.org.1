Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C140279635
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 04:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgIZCWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 22:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbgIZCWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 22:22:35 -0400
Received: from X1 (unknown [104.245.68.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A5120866;
        Sat, 26 Sep 2020 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601086955;
        bh=yONBZOLFobn/XfNSqbInd73Y3EF/XNd7uGysPjXX+BA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TK19VAMIz0cAxC09t8GSQfxw5Vbk8/p15wK/uEoNz2F4UaGxxlh6VJwIdrfeD7wfN
         3RE94dfL12JijaAtruhBkmaewy50WEfL9Dpgn/Quk90C5ZbIiq563PKwsHz6PnUdip
         9oNuqX1UJ8gC0F9Dk7JkdXMqZEcbuNlaZ6RsFGxs=
Date:   Fri, 25 Sep 2020 19:22:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/17] device-dax: add an 'align' attribute
Message-Id: <20200925192234.33ae92b75012c1f2bdd974b8@linux-foundation.org>
In-Reply-To: <160106118486.30709.13012322227204800596.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
        <160106118486.30709.13012322227204800596.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 12:13:04 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> Introduce a device align attribute.  While doing so, rename the region
> align attribute to be more explicitly named as so, but keep it named as
> @align to retain the API for tools like daxctl.
> 
> Changes on align may not always be valid, when say certain mappings were
> created with 2M and then we switch to 1G.  So, we validate all ranges
> against the new value being attempted, post resizing.
> 
> Link: https://lkml.kernel.org/r/159643105944.4062302.3131761052969132784.stgit@dwillia2-desk3.amr.corp.intel.com
> Link: https://lore.kernel.org/r/20200716172913.19658-3-joao.m.martins@oracle.com
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>

The signoff chain implies that this was From:Joao.  Please clarify?
