Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FFD2B8D11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKSI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:27:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:27795 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgKSI1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:27:53 -0500
IronPort-SDR: gnHsiTL7JBKueRs3mwSDteqWdn877kteKCt0yLoyckAbb/uQGrcu7IHC94BT0dfi0zfL0a3XcP
 uN4f315E8JtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="150521935"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="150521935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 00:27:52 -0800
IronPort-SDR: UBBUIewnin4kXuQADohghTzUEFTzy9/xz6+9Vl65UU003DY89cy0KZMaQDvtZKEmwU9/6g0DT7
 H2niybv1F/jA==
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="544918359"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 00:27:48 -0800
Date:   Thu, 19 Nov 2020 16:27:01 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Krystad <peter.krystad@linux.intel.com>,
        Florian Westphal <fw@strlen.de>,
        Christoph Paasch <cpaasch@apple.com>
Subject: net/mptcp/options.c:203:3: warning: Assignment of function parameter
 has no effect outside the function.
Message-ID: <20201119082701.GT3723@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2e7554e1b85935d962127efa3c2a76483b0b3b6
commit: 6d0060f600adfddaa43fefb96b6b12643331961e mptcp: Write MPTCP DSS headers to outgoing data packets
compiler: h8300-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   net/mptcp/options.c:57:4: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
      ptr += 8;
      ^
>> net/mptcp/options.c:203:3: warning: Assignment of function parameter has no effect outside the function. [uselessAssignmentArg]
     remaining -= map_size;
     ^
   net/mptcp/options.c:257:2: warning: Assignment of function parameter has no effect outside the function. [uselessAssignmentArg]
    remaining -= opt_size;
    ^

vim +203 net/mptcp/options.c

6d0060f600adfdd Mat Martineau 2020-01-21  177  
6d0060f600adfdd Mat Martineau 2020-01-21  178  static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
6d0060f600adfdd Mat Martineau 2020-01-21  179  					  unsigned int *size,
6d0060f600adfdd Mat Martineau 2020-01-21  180  					  unsigned int remaining,
6d0060f600adfdd Mat Martineau 2020-01-21  181  					  struct mptcp_out_options *opts)
6d0060f600adfdd Mat Martineau 2020-01-21  182  {
6d0060f600adfdd Mat Martineau 2020-01-21  183  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
6d0060f600adfdd Mat Martineau 2020-01-21  184  	unsigned int dss_size = 0;
6d0060f600adfdd Mat Martineau 2020-01-21  185  	struct mptcp_ext *mpext;
6d0060f600adfdd Mat Martineau 2020-01-21  186  	struct mptcp_sock *msk;
6d0060f600adfdd Mat Martineau 2020-01-21  187  	unsigned int ack_size;
6d0060f600adfdd Mat Martineau 2020-01-21  188  	u8 tcp_fin;
6d0060f600adfdd Mat Martineau 2020-01-21  189  
6d0060f600adfdd Mat Martineau 2020-01-21  190  	if (skb) {
6d0060f600adfdd Mat Martineau 2020-01-21  191  		mpext = mptcp_get_ext(skb);
6d0060f600adfdd Mat Martineau 2020-01-21  192  		tcp_fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
6d0060f600adfdd Mat Martineau 2020-01-21  193  	} else {
6d0060f600adfdd Mat Martineau 2020-01-21  194  		mpext = NULL;
6d0060f600adfdd Mat Martineau 2020-01-21  195  		tcp_fin = 0;
6d0060f600adfdd Mat Martineau 2020-01-21  196  	}
6d0060f600adfdd Mat Martineau 2020-01-21  197  
6d0060f600adfdd Mat Martineau 2020-01-21  198  	if (!skb || (mpext && mpext->use_map) || tcp_fin) {
6d0060f600adfdd Mat Martineau 2020-01-21  199  		unsigned int map_size;
6d0060f600adfdd Mat Martineau 2020-01-21  200  
6d0060f600adfdd Mat Martineau 2020-01-21  201  		map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
6d0060f600adfdd Mat Martineau 2020-01-21  202  
6d0060f600adfdd Mat Martineau 2020-01-21 @203  		remaining -= map_size;
6d0060f600adfdd Mat Martineau 2020-01-21  204  		dss_size = map_size;
6d0060f600adfdd Mat Martineau 2020-01-21  205  		if (mpext)
6d0060f600adfdd Mat Martineau 2020-01-21  206  			opts->ext_copy = *mpext;
6d0060f600adfdd Mat Martineau 2020-01-21  207  
6d0060f600adfdd Mat Martineau 2020-01-21  208  		if (skb && tcp_fin &&
6d0060f600adfdd Mat Martineau 2020-01-21  209  		    subflow->conn->sk_state != TCP_ESTABLISHED)
6d0060f600adfdd Mat Martineau 2020-01-21  210  			mptcp_write_data_fin(subflow, &opts->ext_copy);
6d0060f600adfdd Mat Martineau 2020-01-21  211  	}
6d0060f600adfdd Mat Martineau 2020-01-21  212  
6d0060f600adfdd Mat Martineau 2020-01-21  213  	ack_size = TCPOLEN_MPTCP_DSS_ACK64;
6d0060f600adfdd Mat Martineau 2020-01-21  214  
6d0060f600adfdd Mat Martineau 2020-01-21  215  	/* Add kind/length/subtype/flag overhead if mapping is not populated */
6d0060f600adfdd Mat Martineau 2020-01-21  216  	if (dss_size == 0)
6d0060f600adfdd Mat Martineau 2020-01-21  217  		ack_size += TCPOLEN_MPTCP_DSS_BASE;
6d0060f600adfdd Mat Martineau 2020-01-21  218  
6d0060f600adfdd Mat Martineau 2020-01-21  219  	dss_size += ack_size;
6d0060f600adfdd Mat Martineau 2020-01-21  220  
6d0060f600adfdd Mat Martineau 2020-01-21  221  	msk = mptcp_sk(mptcp_subflow_ctx(sk)->conn);
6d0060f600adfdd Mat Martineau 2020-01-21  222  	if (msk) {
6d0060f600adfdd Mat Martineau 2020-01-21  223  		opts->ext_copy.data_ack = msk->ack_seq;
6d0060f600adfdd Mat Martineau 2020-01-21  224  	} else {
6d0060f600adfdd Mat Martineau 2020-01-21  225  		mptcp_crypto_key_sha(mptcp_subflow_ctx(sk)->remote_key,
6d0060f600adfdd Mat Martineau 2020-01-21  226  				     NULL, &opts->ext_copy.data_ack);
6d0060f600adfdd Mat Martineau 2020-01-21  227  		opts->ext_copy.data_ack++;
6d0060f600adfdd Mat Martineau 2020-01-21  228  	}
6d0060f600adfdd Mat Martineau 2020-01-21  229  
6d0060f600adfdd Mat Martineau 2020-01-21  230  	opts->ext_copy.ack64 = 1;
6d0060f600adfdd Mat Martineau 2020-01-21  231  	opts->ext_copy.use_ack = 1;
6d0060f600adfdd Mat Martineau 2020-01-21  232  
6d0060f600adfdd Mat Martineau 2020-01-21  233  	*size = ALIGN(dss_size, 4);
6d0060f600adfdd Mat Martineau 2020-01-21  234  	return true;
6d0060f600adfdd Mat Martineau 2020-01-21  235  }
6d0060f600adfdd Mat Martineau 2020-01-21  236  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
