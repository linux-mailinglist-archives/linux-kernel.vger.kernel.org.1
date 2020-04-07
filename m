Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0841A129D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 19:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDGRXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 13:23:35 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:26114 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586280213;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bnIN8FKejISJ/Yhf74czIGj7ICfvf3lyv+iHbgoGXng=;
  b=VtsgH6nVHZz+5YGCNEVyTUPHV6WRMrVgQVDJLHlKDS1pT8wVEeK/k46d
   LTv6uc8ZfxZEW4shitnn7K2BDUjlHOq3qIbfq6j4zToVZQimpBWO9Bb/R
   tU9CkOaqeYY2L55r/Rfn4IbQtMHBxvDNJ2FpYcikPrkXjCERT67l0Alip
   c=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 8CRmZTnoOOzUpPBRRDUY3uK4lYB8xTkS/1jb1N2OHMqUpsF1kIGTrSTS53IoBPEbWaG9+nNyfU
 I8UDvTvs9F5Dpdrx9KpwiRv8r93K0FYIQuEsAxjbCAWISianP/a1PicsC9SWtqWMHKFm4dsU91
 D8yVRCqo0I4xi7mDYCyudxfNNFj3Uwi3PpvBgAMVS7Y0cnjNY/CmDo4LwoOqZTEp0eyEf9vNF/
 dfyySLF7us9B+coABwywOy8z09WHMKkhVArjyAzM3kGMCDUyxRdOZ/aaK+kfUMEY0bN4AJQ81u
 zpM=
X-SBRS: 2.7
X-MesageID: 15639610
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,355,1580792400"; 
   d="scan'208";a="15639610"
Subject: Re: [PATCH 0/4] x86/module: Out-of-tree module decode and sanitize
To:     Peter Zijlstra <peterz@infradead.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <hch@infradead.org>, <sean.j.christopherson@intel.com>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <x86@kernel.org>, <kenny@panix.com>, <jeyu@kernel.org>,
        <rasmus.villemoes@prevas.dk>, <pbonzini@redhat.com>,
        <fenghua.yu@intel.com>, <xiaoyao.li@intel.com>,
        <nadav.amit@gmail.com>, <thellstrom@vmware.com>,
        <tony.luck@intel.com>, <rostedt@goodmis.org>,
        <gregkh@linuxfoundation.org>, <jannh@google.com>,
        <keescook@chromium.org>, <David.Laight@aculab.com>,
        <dcovelli@vmware.com>, <mhiramat@kernel.org>
References: <20200407110236.930134290@infradead.org>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <a53a01b9-2907-4eb3-a9fd-16e6e8029028@citrix.com>
Date:   Tue, 7 Apr 2020 18:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407110236.930134290@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2020 12:02, Peter Zijlstra wrote:
> Hi all,
>
> Driven by the SLD vs VMX interaction, here are some patches that provide means
> to analyze the text of out-of-tree modules.
>
> The first user of that is refusing to load modules on VMX-SLD conflicts, but it
> also has a second patch that refulses to load any module that tries to modify
> CRn/DRn.
>
> I'm thinking people will quickly come up with more and more elaborate tests to
> which to subject out-of-tree modules.

Anything playing with LGDT & friends?  Shouldn't be substantially more
elaborate than CR/DR to check for.

~Andrew
