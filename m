Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307E428EE44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgJOILD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:11:03 -0400
Received: from verein.lst.de ([213.95.11.211]:59602 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbgJOIK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:10:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44CA668BEB; Thu, 15 Oct 2020 10:10:55 +0200 (CEST)
Date:   Thu, 15 Oct 2020 10:10:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmet: fix uninitialized work for zero kato
Message-ID: <20201015081054.GC15299@lst.de>
References: <20201015015140.1061936-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015015140.1061936-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to nvme-5.10, thanks.
