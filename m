Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35C81B183E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDTVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 17:19:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:53862 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgDTVTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:19:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E0DA823;
        Mon, 20 Apr 2020 21:19:40 +0000 (UTC)
Date:   Mon, 20 Apr 2020 15:19:39 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Tim Bird <Tim.Bird@sony.com>
Subject: Re: [PATCH v2 0/6] sphinx-pre-install improvements for Kernel 5.8
Message-ID: <20200420151939.10919551@lwn.net>
In-Reply-To: <cover.1586883286.git.mchehab+huawei@kernel.org>
References: <cover.1586883286.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 18:56:07 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This patch series is based on the discussions we had with regards to use
> 
> 	python -m venv
> 
> to create python3 virtual machines.
> 
> After this series, the script will be smarter when detecting python3 and
> python2.
> 
> As I had to re-test it with different distributions, it also do several
> improvements and fixes at the detection logic and at the support for
> some distributions that I don't use (except when testing this script)
> and/or for some corner cases.

This set is easy...applied, thanks.

jon
