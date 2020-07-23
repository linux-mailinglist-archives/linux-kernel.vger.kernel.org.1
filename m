Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71B022B996
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgGWWeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 18:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGWWeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:34:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B33F20737;
        Thu, 23 Jul 2020 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543648;
        bh=8qskPwoWptnD+c7pF1+5A+lmPUNMsPIW8eSn114Sf6U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=yY8QshlfJUEK1Tt11XEEknVWYZ9IaMPmHmqSefGcS14KqU7ntDgoVv2GP16e/5wI1
         jErqDGFUgZxCIHIuXpuiTls18ZBHTZ5vgBEsHwoQU+es9i/SgfrixHNo5LRSH2UCQJ
         ti/BJnj504TQMKbnDAeBuht6MAaxulGKK8aZjQtw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200723074112.3159-4-luca@lucaceresoli.net>
References: <20200723074112.3159-1-luca@lucaceresoli.net> <20200723074112.3159-4-luca@lucaceresoli.net>
Subject: Re: [PATCH v4 3/3] dt-bindings: clk: versaclock5: convert to yaml
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Thu, 23 Jul 2020 15:34:07 -0700
Message-ID: <159554364791.3847286.6369989159213197503@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2020-07-23 00:41:12)
> Convert to yaml the VersaClock bindings document. The mapping between
> clock specifier and physical pins cannot be described formally in yaml
> schema, then keep it verbatim in the description field.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> ---

Applied to clk-next
