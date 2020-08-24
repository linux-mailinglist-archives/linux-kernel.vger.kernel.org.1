Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DF9250B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 00:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgHXWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 18:03:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:56716 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHXWDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:03:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 86E542CB;
        Mon, 24 Aug 2020 22:03:38 +0000 (UTC)
Date:   Mon, 24 Aug 2020 16:03:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-doc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mention documentation maintainer entry
 profile
Message-ID: <20200824160337.6bf6bd04@lwn.net>
In-Reply-To: <20200815102658.12236-1-lukas.bulwahn@gmail.com>
References: <20200815102658.12236-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020 12:26:58 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Since commit 53b7f3aa411b ("Add a maintainer entry profile for
> documentation"), the documentation "subsystem" has a maintainer entry
> profile, and it deserves to be mentioned in MAINTAINERS with a suitable
> P: entry.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Weird, I was sure I'd done that at the time...applied, thanks.

jon
