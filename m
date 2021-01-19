Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4072FC062
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391984AbhASTxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:53:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbhASTrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:47:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JJiHCu064624;
        Tue, 19 Jan 2021 19:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=WNwQhXQsx8BIgN3INwgyf6u2bQoBixmHf1WdPagikKs=;
 b=GS54Bb4Hbb2jiGVtrFpDgDSvXMwtcExlYhyHBtwRtfYSYHYt37ST3n4LIu4lq3WvrKt8
 2AjPs1UhRAX9Tc1IcHpZBgWQpueAIV8DW+dsAG9rn8laJTal/QFQAUdFoumM/YoMQjvm
 PJCFiCiiN96UDIcanN1VxqgIGVso19TY+nz3zpv3WmLqWJvrBOFuf07Odho9dN98mvUf
 in+n/L03M7Rj0uV/rjNEp1QSYr/xou0ceuLGv2zNK6rWYIdGl0B/z17Fs7dxlak4r8vb
 YRHIzKVgBRNCT1Y7pwrFg08fYM++nTMwWHcQKjNYmAtpxgafeI0kSSFoSl4IKnfuxjUW vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 363r3kts2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 19:46:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JJjldd052076;
        Tue, 19 Jan 2021 19:46:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3661er7nub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 19:46:55 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10JJkr2u012454;
        Tue, 19 Jan 2021 19:46:53 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 11:46:53 -0800
Date:   Tue, 19 Jan 2021 22:46:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ilya Dryomov <idryomov@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] net/ceph/messenger_v1.c:1099:23: warning: Boolean result is
 used in bitwise operation. Clarify expression with parentheses.
Message-ID: <20210119194646.GA20820@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: LK24CG3TGJBE45C6AZ4EV3PHKLAARVMC
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   1e2a199f6ccdc15cf111d68d212e2fd4ce65682e
commit: 2f713615ddd9d805b6c5e79c52e0e11af99d2bf1 libceph: move msgr1 protocol implementation to its own file
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> net/ceph/messenger_v1.c:1099:23: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
     BUG_ON(!con->in_msg ^ skip);
                         ^

vim +1099 net/ceph/messenger_v1.c

2f713615ddd9d805 Ilya Dryomov 2020-11-12  1033  static int read_partial_message(struct ceph_connection *con)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1034  {
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1035  	struct ceph_msg *m = con->in_msg;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1036  	int size;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1037  	int end;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1038  	int ret;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1039  	unsigned int front_len, middle_len, data_len;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1040  	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1041  	bool need_sign = (con->peer_features & CEPH_FEATURE_MSG_AUTH);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1042  	u64 seq;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1043  	u32 crc;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1044  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1045  	dout("read_partial_message con %p msg %p\n", con, m);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1046  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1047  	/* header */
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1048  	size = sizeof (con->in_hdr);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1049  	end = size;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1050  	ret = read_partial(con, end, size, &con->in_hdr);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1051  	if (ret <= 0)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1052  		return ret;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1053  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1054  	crc = crc32c(0, &con->in_hdr, offsetof(struct ceph_msg_header, crc));
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1055  	if (cpu_to_le32(crc) != con->in_hdr.crc) {
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1056  		pr_err("read_partial_message bad hdr crc %u != expected %u\n",
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1057  		       crc, con->in_hdr.crc);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1058  		return -EBADMSG;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1059  	}
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1060  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1061  	front_len = le32_to_cpu(con->in_hdr.front_len);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1062  	if (front_len > CEPH_MSG_MAX_FRONT_LEN)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1063  		return -EIO;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1064  	middle_len = le32_to_cpu(con->in_hdr.middle_len);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1065  	if (middle_len > CEPH_MSG_MAX_MIDDLE_LEN)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1066  		return -EIO;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1067  	data_len = le32_to_cpu(con->in_hdr.data_len);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1068  	if (data_len > CEPH_MSG_MAX_DATA_LEN)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1069  		return -EIO;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1070  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1071  	/* verify seq# */
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1072  	seq = le64_to_cpu(con->in_hdr.seq);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1073  	if ((s64)seq - (s64)con->in_seq < 1) {
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1074  		pr_info("skipping %s%lld %s seq %lld expected %lld\n",
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1075  			ENTITY_NAME(con->peer_name),
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1076  			ceph_pr_addr(&con->peer_addr),
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1077  			seq, con->in_seq + 1);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1078  		con->in_base_pos = -front_len - middle_len - data_len -
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1079  			sizeof_footer(con);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1080  		con->in_tag = CEPH_MSGR_TAG_READY;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1081  		return 1;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1082  	} else if ((s64)seq - (s64)con->in_seq > 1) {
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1083  		pr_err("read_partial_message bad seq %lld expected %lld\n",
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1084  		       seq, con->in_seq + 1);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1085  		con->error_msg = "bad message sequence # for incoming message";
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1086  		return -EBADE;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1087  	}
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1088  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1089  	/* allocate message? */
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1090  	if (!con->in_msg) {
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1091  		int skip = 0;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1092  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1093  		dout("got hdr type %d front %d data %d\n", con->in_hdr.type,
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1094  		     front_len, data_len);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1095  		ret = ceph_con_in_msg_alloc(con, &con->in_hdr, &skip);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1096  		if (ret < 0)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1097  			return ret;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1098  
2f713615ddd9d805 Ilya Dryomov 2020-11-12 @1099  		BUG_ON(!con->in_msg ^ skip);

! has higher precedence than ^.  It's not clear that was intended
necessarily.

2f713615ddd9d805 Ilya Dryomov 2020-11-12  1100  		if (skip) {
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1101  			/* skip this message */
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1102  			dout("alloc_msg said skip message\n");
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1103  			con->in_base_pos = -front_len - middle_len - data_len -
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1104  				sizeof_footer(con);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1105  			con->in_tag = CEPH_MSGR_TAG_READY;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1106  			con->in_seq++;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1107  			return 1;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1108  		}
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1109  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1110  		BUG_ON(!con->in_msg);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1111  		BUG_ON(con->in_msg->con != con);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1112  		m = con->in_msg;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1113  		m->front.iov_len = 0;    /* haven't read it yet */
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1114  		if (m->middle)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1115  			m->middle->vec.iov_len = 0;
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1116  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1117  		/* prepare for data payload, if any */
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1118  
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1119  		if (data_len)
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1120  			prepare_message_data(con->in_msg, data_len);
2f713615ddd9d805 Ilya Dryomov 2020-11-12  1121  	}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
