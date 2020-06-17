Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2121FC84A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFQIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 04:06:52 -0400
Received: from verein.lst.de ([213.95.11.211]:42337 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQIGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:06:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E21A468AEF; Wed, 17 Jun 2020 10:06:49 +0200 (CEST)
Date:   Wed, 17 Jun 2020 10:06:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-nvme@lists.infradead.org, james.smart@broadcom.com,
        hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
Message-ID: <20200617080649.GB14863@lst.de>
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526042118.17836-1-dongli.zhang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to nvme-5.9.
