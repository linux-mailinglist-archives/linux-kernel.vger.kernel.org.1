Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFC1F3C3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgFINYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 09:24:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34691 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbgFINYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591709042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mxo8zHzg9OIj2A8/73+xEkgtbWWNNXL8j0TJgSXna7E=;
        b=e1rxoQsQqLY9n1iw7hyES34MsTNdTAbTJw2Jx1W8O/znHsAUDhPs2syyJuC9I98MGZ9U1l
        K0AXxIst/3U6j1gCcBIMloOr/vNqCBu9hPi9ZbMCUrNuad9CLnOaBdcxHGqyIvP+AQzixL
        kSnBAmQAE4DbFxGnkriNVNHYFXIGyyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-G_pMjGYPPfaCWshcEu8IBw-1; Tue, 09 Jun 2020 09:24:00 -0400
X-MC-Unique: G_pMjGYPPfaCWshcEu8IBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D7231883600;
        Tue,  9 Jun 2020 13:23:59 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9A2C5C1D6;
        Tue,  9 Jun 2020 13:23:58 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id A46C01D5; Tue,  9 Jun 2020 10:23:54 -0300 (BRT)
Date:   Tue, 9 Jun 2020 10:23:54 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Subject: Re: [PATCH] perf headers: fix processing of pmu_mappings
Message-ID: <20200609132354.GA8186@redhat.com>
References: <20200608161805.65841-1-eranian@google.com>
 <CAP-5=fXmrbBqDj6udGJCLHF5ePERr1S5qTKGZZAUBC1EmA-8LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXmrbBqDj6udGJCLHF5ePERr1S5qTKGZZAUBC1EmA-8LQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 08, 2020 at 09:52:43AM -0700, Ian Rogers escreveu:
> On Mon, Jun 8, 2020 at 9:18 AM Stephane Eranian <eranian@google.com> wrote:
> A lot of the complexity in this code came from strbuf not \0
> terminating strings. Would a strbuf that always \0 terminated be a
> useful change? In general there's a lack of consistent style with
> strbuf, strcat and asprintf being used in different parts of the code.
> Perhaps strbuf use should migrate to asprintf? There are currently

I think that going to asprintf is best, this came from long ago, when
perf reused parts of the git sources as a starting point.

> just 13 callers of strbuf_init.

- Arnaldo

