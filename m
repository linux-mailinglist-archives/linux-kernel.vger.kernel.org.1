Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43B028DA87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgJNHfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:35:36 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:38860 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgJNHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:35:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1100118224092;
        Wed, 14 Oct 2020 07:35:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1543:1593:1594:1711:1730:1747:1777:1792:1801:2393:2538:2559:2562:2828:2892:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3870:4321:4605:5007:6120:7875:9149:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12296:12297:12438:12555:12679:12740:12760:12895:12986:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30029:30034:30054:30055:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: week96_5108ae82720a
X-Filterd-Recvd-Size: 5175
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 07:35:34 +0000 (UTC)
Message-ID: <4d55bf3eb55ea91639438eb949268b9a42140759.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 14 Oct 2020 00:35:32 -0700
In-Reply-To: <alpine.DEB.2.21.2010140908240.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
         <alpine.DEB.2.21.2010140734270.6186@felia>
         <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
         <alpine.DEB.2.21.2010140812370.6186@felia>
         <be7deeec0937327e0ddaadf8468d934ed363a533.camel@perches.com>
         <alpine.DEB.2.21.2010140829150.6186@felia>
         <04325089b524f20d3de167051bfb81b05083d8b1.camel@perches.com>
         <alpine.DEB.2.21.2010140842310.6186@felia>
         <084a2dabe5463a3528bb052515555f939235c012.camel@perches.com>
         <alpine.DEB.2.21.2010140908240.6186@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 09:17 +0200, Lukas Bulwahn wrote:
> $ clang-format-10 --version
> Ubuntu clang-format version 
> 10.0.1-++20200928083909+ef32c611aa2-1~exp1~20200928185400.194
> 
> $ clang-format-10 --help | grep 'dry-run'
>   --dry-run                  - If set, do not actually make the formatting 
> changes
>   --ferror-limit=<uint>      - Set the maximum number of clang-format
>     errors to emit before stopping (0 = no limit). Used only with --dry-run or -n
>   -n                         - Alias for --dry-run

OK, maybe so.

However I think the clang-format --dry-run output doesn't
currently contain particularly useful information.  Maybe
later versions are better than version 10.

For instance:

$ /usr/bin/clang-format-10 --version
clang-format version 10.0.0-4ubuntu1 

$ /usr/bin/clang-format-10 --dry-run drivers/net/ethernet/intel/igb/igb_main.c 2>&1 | head -25
drivers/net/ethernet/intel/igb/igb_main.c:54:40: warning: code should be clang-formatted [-Wclang-format-violations]
static const char igb_driver_string[] =
                                       ^
drivers/net/ethernet/intel/igb/igb_main.c:56:36: warning: code should be clang-formatted [-Wclang-format-violations]
static const char igb_copyright[] =
                                   ^
drivers/net/ethernet/intel/igb/igb_main.c:100:3: warning: code should be clang-formatted [-Wclang-format-violations]
        {0, }
         ^
drivers/net/ethernet/intel/igb/igb_main.c:100:5: warning: code should be clang-formatted [-Wclang-format-violations]
        {0, }
           ^
drivers/net/ethernet/intel/igb/igb_main.c:163:58: warning: code should be clang-formatted [-Wclang-format-violations]
static int igb_ndo_set_vf_vlan(struct net_device *netdev,
                                                         ^
drivers/net/ethernet/intel/igb/igb_main.c:164:28: warning: code should be clang-formatted [-Wclang-format-violations]
                               int vf, u16 vlan, u8 qos, __be16 vlan_proto);
                                                ^
drivers/net/ethernet/intel/igb/igb_main.c:189:50: warning: code should be clang-formatted [-Wclang-format-violations]
        SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
                                                        ^
drivers/net/ethernet/intel/igb/igb_main.c:190:21: warning: code should be clang-formatted [-Wclang-format-violations]
        SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
                           ^
drivers/net/ethernet/intel/igb/igb_main.c:190:61: warning: code should be clang-formatted [-Wclang-format-violations]

vs

$ ./scripts/checkpatch.pl -f drivers/net/ethernet/intel/igb/igb_main.c 2>&1 | head -25
WARNING: externs should be avoided in .c files
#113: FILE: drivers/net/ethernet/intel/igb/igb_main.c:113:
+int igb_open(struct net_device *);

WARNING: function definition argument 'struct net_device *' should also have an identifier name
#113: FILE: drivers/net/ethernet/intel/igb/igb_main.c:113:
+int igb_open(struct net_device *);

WARNING: externs should be avoided in .c files
#114: FILE: drivers/net/ethernet/intel/igb/igb_main.c:114:
+int igb_close(struct net_device *);

WARNING: function definition argument 'struct net_device *' should also have an identifier name
#114: FILE: drivers/net/ethernet/intel/igb/igb_main.c:114:
+int igb_close(struct net_device *);

CHECK: Alignment should match open parenthesis
#191: FILE: drivers/net/ethernet/intel/igb/igb_main.c:191:
+	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
+			igb_runtime_idle)

CHECK: Please use a blank line after function/struct/union/enum declarations
#193: FILE: drivers/net/ethernet/intel/igb/igb_main.c:193:
+};
+static void igb_shutdown(struct pci_dev *);


