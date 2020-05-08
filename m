Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9151CB409
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEHPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 11:53:45 -0400
Received: from verein.lst.de ([213.95.11.211]:53340 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHPxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:53:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 374DB68C7B; Fri,  8 May 2020 17:53:43 +0200 (CEST)
Date:   Fri, 8 May 2020 17:53:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     hch@lst.de, axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: Re: [PATCH v3 3/3] s390/dasd: remove ioctl_by_bdev calls
Message-ID: <20200508155342.GC4200@lst.de>
References: <20200508131455.55407-1-sth@linux.ibm.com> <20200508131455.55407-4-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508131455.55407-4-sth@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this should use symbol_get instead.
