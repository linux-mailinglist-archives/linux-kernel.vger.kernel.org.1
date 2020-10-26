Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4F298C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771570AbgJZLxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:53:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58406 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770204AbgJZLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:53:37 -0400
Received: from [IPv6:2a00:23c5:9900:2d00:fa7c:ed23:2f0a:448d] (unknown [IPv6:2a00:23c5:9900:2d00:fa7c:ed23:2f0a:448d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1BB191F44D4F;
        Mon, 26 Oct 2020 11:53:36 +0000 (GMT)
Subject: Re: [PATCH] um: include compiler_attributes.h where used
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     Joe Perches <joe@perches.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
References: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
From:   Christopher Obbard <chris.obbard@collabora.com>
Message-ID: <87590278-a3df-0af0-b94f-0eef2cc857c2@collabora.com>
Date:   Mon, 26 Oct 2020 11:53:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2020 11:47, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Joe's commit didn't only convert uses of __section(...) to add
> the quotes, but _also_ converted 'raw' uses of __attribute__(())
> for setting the section to use __section, but didn't update the
> includes where necessary. Add them now.
> 
> Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cause-identified-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>
