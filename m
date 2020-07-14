Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749BA21F6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGNQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 12:15:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727774AbgGNQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594743323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALhmT8jchXhi6XVATYAgVqRU6YHCRQ16pk3Thsq6jqw=;
        b=KRO1zevJsuM7aCLWH9iK/la1EW3cpXLCTeSV0ODRSVQT2BF2xwogU7gUSsFfsV1PsO6X3i
        Og1vT2am3dRKzD6nspp+3SchYOHF7oh/W/u0HQH1vw+sah/FVwUsnNTZsmba2RP7Y2mDxR
        AhpMszts5DKizorXJH9yAHwAQulhmgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-wfCja4aTOWiv3tRLrvVHMg-1; Tue, 14 Jul 2020 12:15:21 -0400
X-MC-Unique: wfCja4aTOWiv3tRLrvVHMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DABEA8027E3;
        Tue, 14 Jul 2020 16:15:19 +0000 (UTC)
Received: from krava (unknown [10.40.193.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id CBEB6710AD;
        Tue, 14 Jul 2020 16:15:16 +0000 (UTC)
Date:   Tue, 14 Jul 2020 18:15:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v11 00/15] perf: support enable and disable commands in
 stat and record modes
Message-ID: <20200714161515.GL183694@krava>
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
 <CAM9d7cgv1dbLMmtUYWXEvoSUC_NQuBpJ9JRBn3tXJ+S5PX+8TQ@mail.gmail.com>
 <20200714151634.GA43671@kernel.org>
 <aaec7646-a032-7457-4283-50037d83ec88@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaec7646-a032-7457-4283-50037d83ec88@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 06:53:26PM +0300, Alexey Budankov wrote:
> 
> On 14.07.2020 18:16, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 14, 2020 at 09:05:10PM +0900, Namhyung Kim escreveu:
> >> Hello,
> >>
> >> On Tue, Jul 14, 2020 at 5:37 PM Alexey Budankov
> >> <alexey.budankov@linux.intel.com> wrote:
> >>>
> >>>
> >>> Changes in v11:
> >>> - added comments to struct ctl_fd
> >>> - explicitly coded data_size decrement
> >>
> >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > So, I think v10 had Jiri's Acked-by, right? Or was it a reviewed-by?
> > Please next time collect those, helps with reviewing, Jiri?
> 
> Right, v10 has got Acked-by Jiri Olsa [1]. 

yes, I ack-ed it

jirka

> I should have already learned this lesson on CAP_PERFMON patches
> so will try my best to get this done thus far.
> 
> Thanks,
> Alexei
> 
> [1] https://lore.kernel.org/lkml/20200712211204.GA156308@krava/
> 

