Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C537201B73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbgFSTkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:40:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:55376 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389584AbgFSTkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:40:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 362FE23B;
        Fri, 19 Jun 2020 19:40:23 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:40:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/translations/zh_CN
Message-ID: <20200619134022.05a51861@lwn.net>
In-Reply-To: <20200608181649.74883-1-grandmaster@al2klimov.de>
References: <20200608181649.74883-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Jun 2020 20:16:49 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   For each line:
>     If doesn't contain `\bxmlns\b`:
>       For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>         If both the HTTP and HTTPS versions
>         return 200 OK and serve the same content:
>           Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied, thanks.

jon
