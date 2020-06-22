Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8120358F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgFVLXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 07:23:10 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28826 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728918AbgFVLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:22:36 -0400
X-IronPort-AV: E=Sophos;i="5.75,266,1589234400"; 
   d="scan'208";a="455981487"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:22:33 +0200
Date:   Mon, 22 Jun 2020 13:22:33 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [v3] coccinelle: misc: add array_size_dup script to detect missed
 overflow checks
In-Reply-To: <5f91ec99-5c21-78c2-f484-76a0b5bd3e71@web.de>
Message-ID: <alpine.DEB.2.22.394.2006221321180.2531@hadrien>
References: <5f91ec99-5c21-78c2-f484-76a0b5bd3e71@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-558735236-1592824953=:2531"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-558735236-1592824953=:2531
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> I suggest to take another look at information from the section
> “2.4.3. Formatted string literals”.
> https://docs.python.org/3/reference/lexical_analysis.html#f-strings
>
> This software documentation provides the information “New in version 3.6”.
> Will such a detail trigger any more software development consequences?

Thanks foor this information.  Denis, would it be possible to express the
code in a more portable way?

thanks,
julia
--8323329-558735236-1592824953=:2531--
