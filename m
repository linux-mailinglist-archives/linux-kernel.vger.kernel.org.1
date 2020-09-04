Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8F25D572
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgIDJx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:53:59 -0400
Received: from 8bytes.org ([81.169.241.247]:41058 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgIDJxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:53:55 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6962C9CE; Fri,  4 Sep 2020 11:53:54 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:53:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        sean.m.osborne@oracle.com, james.puthukattukaran@oracle.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com
Subject: Re: [PATCH 0/2 v2] iommu: amd: Fix intremap IO_PAGE_FAULT for VMs
Message-ID: <20200904095352.GR6714@8bytes.org>
References: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903093822.52012-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:38:20AM +0000, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (2):
>   iommu: amd: Restore IRTE.RemapEn bit after programming IRTE
>   iommu: amd: Use cmpxchg_double() when updating 128-bit IRTE

Applied both for v5.9, thanks Suravee.

