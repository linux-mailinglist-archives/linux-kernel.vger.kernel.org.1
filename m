Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A02275965
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIWOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:07:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E565821D92;
        Wed, 23 Sep 2020 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600870058;
        bh=s7f+06avqlIZH5laQfpv/IFSlWthi5o7RtJN/jEa6zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh0iNHh8w5lG80MNqVefUEub9Nbxqrg3sdnJmOVEJaBpGs+AtV+OztWOWY83deYMv
         WrkUxYo1csTkfiftO+c0FUm6czaxSRuyHCX4A7yNmuh11sK9Ed7yJmFxAjTA34g7Cc
         u6LgYrMiY+Pz2eXbB0vENKqvlqixWU2ycZKKn2rI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8F59400E9; Wed, 23 Sep 2020 11:07:34 -0300 (-03)
Date:   Wed, 23 Sep 2020 11:07:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] perf script: add min, max to futex-contention
Message-ID: <20200923140734.GA2517482@kernel.org>
References: <20200921201928.799498-2-hagen@jauu.net>
 <20200922200922.1306034-1-hagen@jauu.net>
 <20200923123155.GA2516911@kernel.org>
 <137056436.64108.1600864811088@office.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137056436.64108.1600864811088@office.mailbox.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 23, 2020 at 02:40:10PM +0200, Hagen Paul Pfeifer escreveu:
> > On 09/23/2020 2:31 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Didn't apply here, I did it by hand, please check, probably some
> > indentation artifact.
> 
> Probably you missed patch one of the patchset - the autopep8 formatting
> one for the lock contention script?

Right, I missed that, I'm removing my "fix", autopep'in and then
reapplying your verbatin 2/2 patch.
 
> > Thanks for the patch!
> 
> You are welcome Arnaldo!
> 
> Hagen

-- 

- Arnaldo
