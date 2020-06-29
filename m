Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123AB20E869
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391920AbgF2WGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 18:06:43 -0400
Received: from muru.com ([72.249.23.125]:59940 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgF2SfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:14 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 590AB81C2;
        Mon, 29 Jun 2020 18:27:18 +0000 (UTC)
Date:   Mon, 29 Jun 2020 11:26:22 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 07/10] regulator: cpcap-regulator: Remove declared and
 set, but never used variable 'ignore'
Message-ID: <20200629182622.GC37466@atomide.com>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
 <20200625191708.4014533-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625191708.4014533-8-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [200625 19:18]:
> It's okay to not check the return value that you're not conserned
> about, however it is not okay to assign a variable and not check or
> use the result.
> 
> Fixes W=1 warnings(s):
> 
>  drivers/regulator/cpcap-regulator.c:172:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
>  172 | int error, ignore;
>  | ^~~~~~
>  drivers/regulator/cpcap-regulator.c: In function ‘cpcap_regulator_disable’:
>  drivers/regulator/cpcap-regulator.c:196:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
>  196 | int error, ignore;

Acked-by: Tony Lindgren <tony@atomide.com>
