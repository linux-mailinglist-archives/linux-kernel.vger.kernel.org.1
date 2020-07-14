Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171921F5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgGNPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNPQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:16:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58A6223FB;
        Tue, 14 Jul 2020 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594739797;
        bh=8dTO9PLXvIm7/AVLONCljqRVzNQDWz6iSFvrIeWSHOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVL5XpXI7+318g8hPN4IqiDLi+fa3xShibT8cS6spEwVfqOX9I3KdE8TbH9VHcpYl
         YZ0+5bglEZtSkq6zvf0hjX6mAXiDj+5GWAn1YvUPqR/3jI3XrDfZXe7eEjWTCGxTMa
         QdpD526THZMo9jHtxgO1AO48aGkv+c6dbB22ncUI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48D2F40094; Tue, 14 Jul 2020 12:16:34 -0300 (-03)
Date:   Tue, 14 Jul 2020 12:16:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v11 00/15] perf: support enable and disable commands in
 stat and record modes
Message-ID: <20200714151634.GA43671@kernel.org>
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
 <CAM9d7cgv1dbLMmtUYWXEvoSUC_NQuBpJ9JRBn3tXJ+S5PX+8TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgv1dbLMmtUYWXEvoSUC_NQuBpJ9JRBn3tXJ+S5PX+8TQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 14, 2020 at 09:05:10PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Jul 14, 2020 at 5:37 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
> >
> >
> > Changes in v11:
> > - added comments to struct ctl_fd
> > - explicitly coded data_size decrement
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

So, I think v10 had Jiri's Acked-by, right? Or was it a reviewed-by?
Please next time collect those, helps with reviewing, Jiri?

- Arnaldo
