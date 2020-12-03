Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1752CCFC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgLCGrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:47:17 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:28375 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgLCGrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:47:16 -0500
IronPort-SDR: J5JZ+jl5yejxI/vXpE30ESShZIrKMfHC5dKjvYBkDXjkIy4kb4Bm5104PkDtVHYGrUmsgQYbQA
 Qs2n2vredJXCp7pzOGfEjUu013mbE5x2//E5Xk3oBxopiQ4lYWstogItFDYPcNZCsxnNvXkz71
 B80MOIW8XfBnRkLTE1i0zRiQRB1dANp2rcuxhdsXUMDQY0qmrTcVsni172a5IRJkbzu5MHDgc+
 Yk3Rr98WWGtsy6VrTR8krXKhRsR0Nc8DmWifzq+VdcYP8le8jkBEEhgerm7rtkV5gpeXzGTpGB
 VbA=
X-IronPort-AV: E=Sophos;i="5.78,388,1599552000"; 
   d="scan'208";a="58035282"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 02 Dec 2020 22:46:21 -0800
IronPort-SDR: gJMY6Y/MU+UaXt3QljKs5RRVRB7NvxgCIP09XQgQH74ALAsBuRzPslp00xEDEHiAgJSdmPu3x0
 DudZT/WjjAXTKiAMZGLzyrUDhytFPmTYpDf5gg45240zJ2zkN4LKAmCVOw5/epkVMsFCJFXcN7
 o3NIKio6ASxnrn19ZZcqYwLSIoAozvEmfbvICzJCZiCZPa+8nLg3iHp6AD2m2vFLVSLwDAIHEy
 cQcoWcd9fj4mDKQ8qxevS9aefXecPsOslNNoBVYWpWeFGxHHAg9WGUg5VPiBMqSCHIsDW/pMY8
 WnU=
Subject: Re: [PATCH v0] ASoC: rsnd: core: Check convert rate in rsnd_hw_params
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1606907286-32104-1-git-send-email-mikhail_durnev@mentor.com>
 <87sg8nbz4o.wl-kuninori.morimoto.gx@renesas.com>
From:   Mikhail Durnev <Mikhail_Durnev@mentor.com>
Message-ID: <866c9619-757b-831b-6955-9245a6071adc@mentor.com>
Date:   Thu, 3 Dec 2020 16:46:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87sg8nbz4o.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.2020 08:57, Kuninori Morimoto wrote:
> I think you want to add "fallthrough" between case 1/3/4 and case 0 ?
Hi Morimoto-san,

Yes, I will add it in the updated version of the patch. Thanks.
The checkpatch script did not tell me about that.

Best regards,
Misha
