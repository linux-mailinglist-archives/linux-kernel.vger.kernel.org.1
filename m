Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97CB226051
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgGTNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 09:00:39 -0400
Received: from verein.lst.de ([213.95.11.211]:46803 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgGTNAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:00:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67FD668BFE; Mon, 20 Jul 2020 15:00:36 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:00:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        rjw@rjwysocki.net
Subject: Re: [PATCH] configfs: Use flush file op to commit writes to a
 binary file
Message-ID: <20200720130036.GA32363@lst.de>
References: <20200716225517.29522-1-lszubowi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716225517.29522-1-lszubowi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the configfs tree.
