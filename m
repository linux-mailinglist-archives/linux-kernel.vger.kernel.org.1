Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2528F2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgJONKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:10:49 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:60404 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgJONKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1602767449;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f6Kamy1C8O875JTu/vLF90Ddc8FWBrVKHooa1uTjaeQ=;
  b=GiwHxNBo3AM1dAKmOq+ocxQ12EWakbP8ln/kaGJjlJ52EMDN/Y6cZbkB
   IA/R1iInSnZw+ESaqiNN8y0qv17WgiENehjA7NTxmvPyvUiEAHY21Si3C
   z82oIZukBDcB7oDVkiJ1PDvxyKMpfTHhA/iKGrPAZ+sLUaxZhwqBxEBur
   8=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: TsNzbLxMsk384nJy5Ma5vOQoKEjgU+ipNL1nJSmtDZ6qs87H2v+vbvQIN4MbbD72V2Ey2BJWzK
 DJ2By9UKxVmig34H8L3MwHOYlSQxz2DBF8RnLL026OOdZRjfNPY566lXkCEMWpefwuzoeGsvFt
 SnTPGz44+AtTSC4bBi08uZqWHQKJcn+DFJ+74bUEgEdXNlB7yWOUEr2CPons5/qNhxHYKojNNA
 H5bJ7MetpyQXJ0vK5ZCl6jO/6csbfhHTojPmAvbq5tYkHveVjp4yyTrmmaBCv2pnjkGKD8M7ZL
 4Bg=
X-SBRS: 2.5
X-MesageID: 29078535
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,379,1596513600"; 
   d="scan'208";a="29078535"
Subject: Re: [PATCH 2/2] xen: Kconfig: nest Xen guest options
To:     <boris.ostrovsky@oracle.com>, Jason Andryuk <jandryuk@gmail.com>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
References: <20201014175342.152712-1-jandryuk@gmail.com>
 <20201014175342.152712-3-jandryuk@gmail.com>
 <6cd9363c-ac0c-ea68-c8e7-9fd3cd30a89b@oracle.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <4e31301b-0e57-ac89-cd71-6ad5e1a66628@citrix.com>
Date:   Thu, 15 Oct 2020 14:10:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6cd9363c-ac0c-ea68-c8e7-9fd3cd30a89b@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL05.citrite.net (10.13.108.178)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2020 13:37, boris.ostrovsky@oracle.com wrote:
> On 10/14/20 1:53 PM, Jason Andryuk wrote:
>> +config XEN_512GB
>> +	bool "Limit Xen pv-domain memory to 512GB"
>> +	depends on XEN_PV && X86_64
>
> Why is X86_64 needed here?

>512G support was implemented using a direct-mapped P2M, and is rather
beyond the virtual address capabilities of 32bit.

~Andrew
