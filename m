Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05081E82A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgE2P7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 11:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgE2P7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:59:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A7F2072D;
        Fri, 29 May 2020 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590767947;
        bh=VzmONYoZ1NiOqrvgLKYRTNZmB1gMj7QtP1/8E6WrElk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zAbJlZeJ04N2S9fB1FWPLhO5n9QXjxjVz1+072GDVP/e4v+VUis/GpeS89gjM/NZ5
         MeP7pUaPkzLT+briUXfE9w8lHRG90W7RgCjQo7yBKzYsbpFPVV1O5cNgarJy7ckKVs
         ykdsJ41PYSUYdaRCVHPNj2xAiY+y2ihVg6ZV3fts=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFED240AFD; Fri, 29 May 2020 12:59:04 -0300 (-03)
Date:   Fri, 29 May 2020 12:59:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Nick Gasson <nick.gasson@arm.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf jvmti: Remove redundant jitdump line table
 entries
Message-ID: <20200529155904.GA537@kernel.org>
References: <20200528054049.13662-1-nick.gasson@arm.com>
 <CAP-5=fWcMKtPa3C9Jbyf=zY=YmTRaoiyc837nYJcK9pC+NJ-LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWcMKtPa3C9Jbyf=zY=YmTRaoiyc837nYJcK9pC+NJ-LA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 28, 2020 at 12:31:31AM -0700, Ian Rogers escreveu:
> On Wed, May 27, 2020 at 10:41 PM Nick Gasson <nick.gasson@arm.com> wrote:
> > +                                 */
> 
> Thanks!
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
