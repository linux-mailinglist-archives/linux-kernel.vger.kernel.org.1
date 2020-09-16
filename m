Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF826C889
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgIPSwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbgIPSwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:52:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C89205F4;
        Wed, 16 Sep 2020 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600282342;
        bh=CxyHWU7pheHAvxP9UL5ssP9QvZNkatmypLqD+qw8EWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6nS8W/E3QhCECEJ6zNwIVVH4SwwCO9bxgL35LT+z58De7DAShQv5edtACpCZ27iy
         hgcM7CLpU5DE0aziWV6xAdqkhu9nqnQBAN+kiY91OdwnElBuAB6mIXxpM/TTzy2c9/
         Tmgt3h6hJIIye9MlA97HrZqsbhsAnALbs9a/KYt0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 108B9400E9; Wed, 16 Sep 2020 15:52:19 -0300 (-03)
Date:   Wed, 16 Sep 2020 15:52:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Frank Ch. Eigler" <fche@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf probe: Support debuginfod client
Message-ID: <20200916185218.GA1322686@kernel.org>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
 <20200916181307.GB16238@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916181307.GB16238@redhat.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 16, 2020 at 02:13:07PM -0400, Frank Ch. Eigler escreveu:
> Hi -
> 
> Nice, even uses the source code fetching part of the webapi!

So, can I take that as an Acked-by or Reviewed-by? 

:-)

- Arnaldo

I need to support this in pahole...
 
> - FChE
> 

-- 

- Arnaldo
