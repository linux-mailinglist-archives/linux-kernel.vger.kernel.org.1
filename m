Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC461A0512
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 04:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDGC7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 22:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgDGC7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:59:14 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9EB206B8;
        Tue,  7 Apr 2020 02:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586228353;
        bh=uCEYpsh9Jd3K0aQzSvHvZohM9flM5mt0gbSjnm7/fRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F83BPuKRPnc+n9k++4IHrZRu3SWw4fwo5TjPh13e8iM/wXxKm5WFfFFFnnjkQFJau
         aFpwsHskvObGjROB/ii3oJuow/hRFM33NFCqiNkxnBy5ILTP/iFKw8isnzyS5Vrzwo
         CFyL86GW53bNQppJ7R0T0+KC+R0rKNAWnJJs9+qY=
Date:   Mon, 6 Apr 2020 19:59:13 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce sysfs/data_io_flag to attach
 REQ_META/FUA
Message-ID: <20200407025913.GB137081@google.com>
References: <20200403161249.68385-1-jaegeuk@kernel.org>
 <0e627c29-7fb0-5bd6-c1d9-b96a94df62ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e627c29-7fb0-5bd6-c1d9-b96a94df62ae@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07, Chao Yu wrote:
> On 2020/4/4 0:12, Jaegeuk Kim wrote:
> > This patch introduces a way to attach REQ_META/FUA explicitly
> > to all the data writes given temperature.
> > 
> > -> attach REQ_FUA to Hot Data writes
> > 
> > -> attach REQ_FUA to Hot|Warm Data writes
> > 
> > -> attach REQ_FUA to Hot|Warm|Cold Data writes
> > 
> > -> attach REQ_FUA to Hot|Warm|Cold Data writes as well as
> >           REQ_META to Hot Data writes
> 
> Out of curiosity, what scenario it is used for?

It's testing purpose to compare the bandwidths per different IO flags.

> 
> Thanks,
